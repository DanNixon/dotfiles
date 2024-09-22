use super::CliRun;
use crate::helpers::{
    run_fzf,
    sway::{focus_container, get_container_id_from_fzf_string, get_containers_fzf_strings},
};

pub(crate) struct FocusWindow {}

impl CliRun for FocusWindow {
    fn run(&self, sway: &mut swayipc::Connection) -> crate::Result<()> {
        let tree = sway.get_tree()?;

        let mut items = Vec::new();
        get_containers_fzf_strings(&tree, None, &mut items);

        let selection = run_fzf("window to focus", items)?;

        let container_id = get_container_id_from_fzf_string(&selection)?;

        focus_container(sway, &container_id)
    }
}
