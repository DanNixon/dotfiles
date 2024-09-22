use super::CliRun;
use crate::helpers::{
    run_fzf,
    sway::{
        focus_container, get_container_id_from_fzf_string, get_containers_fzf_strings,
        get_workspace_names, move_container_to_workspace, FocusedWorkspacePosition,
    },
};

pub(crate) struct MoveWindowHere {}

impl CliRun for MoveWindowHere {
    fn run(&self, sway: &mut swayipc::Connection) -> crate::Result<()> {
        let tree = sway.get_tree()?;

        let mut items = Vec::new();
        get_containers_fzf_strings(&tree, None, &mut items);

        let selection = run_fzf("window to move", items)?;

        let container_id = get_container_id_from_fzf_string(&selection)?;

        let workspace_names = get_workspace_names(sway, FocusedWorkspacePosition::Front)?;

        move_container_to_workspace(
            sway,
            &container_id,
            workspace_names
                .first()
                .expect("there should be at least one workspace"),
        )?;

        focus_container(sway, &container_id)
    }
}

pub(crate) struct MoveWindowToWorkspace {}

impl CliRun for MoveWindowToWorkspace {
    fn run(&self, sway: &mut swayipc::Connection) -> crate::Result<()> {
        let tree = sway.get_tree()?;

        let mut items = Vec::new();
        get_containers_fzf_strings(&tree, None, &mut items);

        let selection = run_fzf("window to move", items)?;

        let container_id = get_container_id_from_fzf_string(&selection)?;

        // Get a list of all the workspace names, with the focused workspace at the front (allowing
        // fastest access to editing).
        let workspace_names = get_workspace_names(sway, FocusedWorkspacePosition::Front)?;

        // Fuzzy select a workspace.
        let workspace_name = run_fzf("workspace to move to", workspace_names)?;

        move_container_to_workspace(sway, &container_id, &workspace_name)
    }
}
