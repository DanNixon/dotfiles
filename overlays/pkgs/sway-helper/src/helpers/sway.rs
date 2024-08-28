use regex::Regex;
use std::cmp::Ordering;
use swayipc::{Node, NodeType};

pub(crate) fn run_program(sway: &mut swayipc::Connection, program: &str) -> crate::Result<()> {
    sway.run_command(format!("exec \"{program}\""))?;
    Ok(())
}

pub(crate) enum FocusedWorkspacePosition {
    Front,
    // Sorted,
    Back,
}

pub(crate) fn get_workspace_names(
    sway: &mut swayipc::Connection,
    focused: FocusedWorkspacePosition,
) -> crate::Result<Vec<String>> {
    let mut workspaces = sway.get_workspaces()?;

    workspaces.sort_by(|a, b| match focused {
        FocusedWorkspacePosition::Front => {
            if a.focused == b.focused {
                Ordering::Equal
            } else if a.focused {
                Ordering::Less
            } else {
                Ordering::Greater
            }
        }
        // FocusedWorkspacePosition::Sorted => Ordering::Equal,
        FocusedWorkspacePosition::Back => {
            if a.focused == b.focused {
                Ordering::Equal
            } else if a.focused {
                Ordering::Greater
            } else {
                Ordering::Less
            }
        }
    });

    Ok(workspaces.into_iter().map(|i| i.name).collect())
}

pub(crate) fn get_containers_fzf_strings<'a>(
    node: &'a Node,
    mut parent_workspace: Option<&'a Node>,
    strings: &mut Vec<String>,
) {
    if node.node_type == NodeType::Workspace {
        parent_workspace = Some(node);
    }

    if (node.node_type == NodeType::Con || node.node_type == NodeType::FloatingCon)
        && node.nodes.is_empty()
    {
        let mut s = String::new();

        if let Some(ws) = &parent_workspace {
            if let Some(name) = &ws.name {
                s.push_str(&format!("[{name}] "));
            }
        }

        if let Some(app_id) = &node.app_id {
            s.push_str(&format!("[{app_id}] "));
        }

        s.push_str(&format!(
            "{} ",
            match &node.name {
                Some(name) => name,
                None => "<no name>",
            }
        ));

        s.push_str(&format!("(id={})", node.id));

        strings.push(s);
    }

    for child in node.nodes.iter() {
        get_containers_fzf_strings(child, parent_workspace, strings);
    }
    for child in node.floating_nodes.iter() {
        get_containers_fzf_strings(child, parent_workspace, strings);
    }
}

pub(crate) fn get_container_id_from_fzf_string(s: &str) -> crate::Result<String> {
    let re = Regex::new(r".+ \(id=(\w+)\)$").expect("regex expression should be valid");

    let captures = re
        .captures(s)
        .ok_or_else(|| crate::Error::WindowInvalidInput(s.to_string()))?;

    Ok(captures[1].to_string())
}

pub(crate) fn focus_container(
    sway: &mut swayipc::Connection,
    container_id: &str,
) -> crate::Result<()> {
    sway.run_command(format!("[con_id={container_id}] focus"))?;
    Ok(())
}

pub(crate) fn move_container_to_workspace(
    sway: &mut swayipc::Connection,
    container_id: &str,
    workspace_name: &str,
) -> crate::Result<()> {
    sway.run_command(format!(
        "[con_id={container_id}] move to workspace {workspace_name}"
    ))?;
    Ok(())
}
