use super::CliRun;
use crate::helpers::{programs::list_programs_from_path, sway::run_program};

pub(crate) struct Run {}

impl CliRun for Run {
    fn run(&self, sway: &mut swayipc::Connection) -> crate::Result<()> {
        // Get a list of all programs in PATH.
        let selection = list_programs_from_path();

        // Fuzzy select a program.
        let program = crate::helpers::run_fzf("run", selection)?;

        // Run the selected program.
        run_program(sway, &program)
    }
}
