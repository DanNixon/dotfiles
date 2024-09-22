use super::CliRun;
use crate::helpers::{programs::list_programs_from_path, run_fzf, sway::run_program};

pub(crate) struct PathRun {}

impl CliRun for PathRun {
    fn run(&self, sway: &mut swayipc::Connection) -> crate::Result<()> {
        // Get a list of all programs in PATH.
        let selection = list_programs_from_path();

        // Fuzzy select a program.
        let program = run_fzf("run", selection)?;

        // Run the selected program.
        run_program(sway, &program)
    }
}
