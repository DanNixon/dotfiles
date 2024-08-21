use super::CliRun;
use crate::helpers::edit_single_line;
use swayipc::{Node, NodeType};

pub(crate) struct NewWorkspace {}

impl CliRun for NewWorkspace {
    fn run(&self, sway: &mut swayipc::Connection) -> crate::Result<()> {
        // Generate a default name for the workspace.
        let name = generate_new_workspace_name(sway)?;

        // Create and focus the new workspace.
        create_new_workspace(sway, &name)
    }
}

pub(crate) struct NewNamedWorkspace {}

impl CliRun for NewNamedWorkspace {
    fn run(&self, sway: &mut swayipc::Connection) -> crate::Result<()> {
        // Generate a default name for the workspace.
        let name = generate_new_workspace_name(sway)?;

        // Allow the user to edit it.
        let name = edit_single_line(&name)?;

        // Create and focus the new workspace.
        create_new_workspace(sway, &name)
    }
}

fn generate_new_workspace_name(sway: &mut swayipc::Connection) -> crate::Result<String> {
    let tree = sway.get_tree()?;
    let mut workspaces = Vec::new();
    list_workspaces(&tree, &mut workspaces);

    // Determine the highest workspace number currently in use.
    let highest_ws_number = workspaces.into_iter().flat_map(|ws| ws.number).max();

    // Create a name for the new workspace that is the highest workspace number plus one, or
    // zero if there are no numbered workspaces in use.
    Ok(match highest_ws_number {
        Some(num) => num + 1,
        None => 0,
    }
    .to_string())
}

/// Create and focus the new workspace.
fn create_new_workspace(sway: &mut swayipc::Connection, name: &str) -> crate::Result<()> {
    sway.run_command(format!("workspace \"{name}\""))?;
    Ok(())
}

#[derive(Debug)]
struct WorkspaceDetails {
    number: Option<i32>,
}

fn list_workspaces(node: &Node, workspaces: &mut Vec<WorkspaceDetails>) {
    if node.node_type == NodeType::Workspace {
        workspaces.push(WorkspaceDetails { number: node.num });
    }

    for child in node.nodes.iter() {
        list_workspaces(child, workspaces);
    }
}
