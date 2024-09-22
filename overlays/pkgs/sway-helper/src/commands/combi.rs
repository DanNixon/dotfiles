use super::CliRun;
use crate::helpers::{
    freedesktop::{
        find_all_freedesktop_app_launchables, launch_freedesktop_app,
        parse_freedesktop_app_and_action,
    },
    run_fzf,
    sway::{focus_container, get_container_id_from_fzf_string, get_containers_fzf_strings},
};
use clap::Parser;
use colored::Colorize;
use regex::Regex;

pub(crate) struct Combi {}

const WIN: &str = "win";
const CMD: &str = "cmd";
const APP: &str = "app";

impl CliRun for Combi {
    fn run(&self, sway: &mut swayipc::Connection) -> crate::Result<()> {
        let mut options = Vec::default();

        // Get a list of windows/containers.
        let tree = sway.get_tree()?;
        let mut containers = Vec::new();
        get_containers_fzf_strings(&tree, None, &mut containers);

        options.extend(containers.iter().map(|i| format!("[{}] {i}", WIN.green())));

        // Get a list of subcommands (not already covered by other included items).
        options.extend(
            [
                "new-workspace",
                "new-named-workspace",
                "rename-workspace",
                "switch-to-workspace",
                "move-window-here",
                "move-window-to-workspace",
                "path-run",
            ]
            .iter()
            .map(|i| format!("[{}] {i}", CMD.yellow())),
        );

        // Get a list of freedesktop applications and their actions
        options.extend(
            find_all_freedesktop_app_launchables()
                .iter()
                .map(|i| format!("[{}] {i}", APP.blue())),
        );

        // Fuzzy select something.
        let selected = run_fzf("combi", options)?;

        // Extract info from the selected item.
        let re = Regex::new(r"\[(\w+)\] (.+)$").expect("regex expression should be valid");

        let invalid_input_error = || crate::Error::CombiInvalidInput(selected.clone());

        let captures = re.captures(&selected).ok_or_else(invalid_input_error)?;
        let (cmd, arg) = (&captures[1], &captures[2]);

        // Do the appropriate thing.
        match cmd {
            WIN => {
                let container_id = get_container_id_from_fzf_string(arg)?;
                focus_container(sway, &container_id)
            }
            CMD => {
                let cli =
                    crate::Cli::try_parse_from(["", arg]).map_err(|_| invalid_input_error())?;
                cli.command.run(sway)
            }
            APP => {
                // Parse the app ID and action from the selected launchable.
                let (app_id, action) = parse_freedesktop_app_and_action(arg)?;
                // Launch the application.
                launch_freedesktop_app(sway, app_id, action)
            }
            _ => Err(invalid_input_error()),
        }
    }
}
