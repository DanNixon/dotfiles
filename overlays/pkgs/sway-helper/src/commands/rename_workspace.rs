use super::CliRun;
use crate::helpers::{
    edit_single_line, run_fzf,
    sway::{get_workspace_names, FocusedWorkspacePosition},
};

pub(crate) struct RenameWorkspace {}

impl CliRun for RenameWorkspace {
    fn run(&self, sway: &mut swayipc::Connection) -> crate::Result<()> {
        // Get a list of all the workspace names, with the focused workspace at the front (allowing
        // fastest access to editing).
        let workspace_names = get_workspace_names(sway, FocusedWorkspacePosition::Front)?;

        // Fuzzy select a workspace.
        let selected = run_fzf("workspace to rename", workspace_names)?;

        // Get a new name for the workspace.
        let new_name = edit_single_line(&selected)?;

        // Rename the workspace.
        sway.run_command(format!("rename workspace \"{selected}\" to \"{new_name}\""))?;

        Ok(())
    }
}
