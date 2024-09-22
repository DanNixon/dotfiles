use super::CliRun;
use crate::helpers::{
    run_fzf,
    sway::{get_workspace_names, FocusedWorkspacePosition},
};

pub(crate) struct SwitchToWorkspace {}

impl CliRun for SwitchToWorkspace {
    fn run(&self, sway: &mut swayipc::Connection) -> crate::Result<()> {
        // Add "back_and_forth" at the start of the list to allow very fast switching between the
        // last two focused workspaces.
        let mut workspace_names = vec!["back_and_forth".to_string()];

        // Add the names of all the workspaces, with the name of the current workspace at the back.
        workspace_names.append(&mut get_workspace_names(
            sway,
            FocusedWorkspacePosition::Back,
        )?);

        // Fuzzy select a workspace.
        let selection = run_fzf("workspace", workspace_names)?;

        // Switch to the selected workspace.
        sway.run_command(format!("workspace {selection}"))?;

        Ok(())
    }
}
