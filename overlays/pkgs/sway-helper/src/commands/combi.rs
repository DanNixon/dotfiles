use super::CliRun;
use crate::helpers::{
    programs::list_programs_from_path,
    sway::{
        focus_container, get_container_id_from_fzf_string, get_containers_fzf_strings, run_program,
    },
};
use clap::Parser;
use colored::Colorize;
use regex::Regex;

pub(crate) struct Combi {}

const WIN: &str = "win";
const CMD: &str = "cmd";
const RUN: &str = "run";

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
                "move-window-to-workspace",
            ]
            .iter()
            .map(|i| format!("[{}] {i}", CMD.yellow())),
        );

        // Get a list of all programs in PATH.
        options.extend(
            &mut list_programs_from_path()
                .iter()
                .map(|i| format!("[{}] {i}", RUN.blue())),
        );

        // Fuzzy select something.
        let selected = crate::helpers::run_fzf("combi", options)?;

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
            RUN => run_program(sway, arg),
            _ => Err(invalid_input_error()),
        }
    }
}
