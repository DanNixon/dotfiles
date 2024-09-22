use super::CliRun;
use crate::helpers::{
    freedesktop::{
        find_all_freedesktop_app_launchables, launch_freedesktop_app,
        parse_freedesktop_app_and_action,
    },
    run_fzf,
};

pub(crate) struct AppRun {}

impl CliRun for AppRun {
    fn run(&self, sway: &mut swayipc::Connection) -> crate::Result<()> {
        // Get a list of all freedesktop app launchables.
        let launchables = find_all_freedesktop_app_launchables();

        // Fuzzy select a program.
        let selected = run_fzf("app", launchables)?;

        // Parse the app ID and action from the selected launchable.
        let (app_id, action) = parse_freedesktop_app_and_action(&selected)?;

        // Launch the application.
        launch_freedesktop_app(sway, app_id, action)
    }
}
