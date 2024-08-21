mod combi;
mod focus_window;
mod new_workspace;
mod rename_workspace;
mod run;
mod switch_to_workspace;

use self::{
    combi::Combi,
    focus_window::FocusWindow,
    new_workspace::{NewNamedWorkspace, NewWorkspace},
    rename_workspace::RenameWorkspace,
    run::Run,
    switch_to_workspace::SwitchToWorkspace,
};
use clap::Subcommand;

pub(crate) trait CliRun {
    fn run(&self, sway: &mut swayipc::Connection) -> crate::Result<()>;
}

#[derive(Debug, Subcommand)]
pub(crate) enum Command {
    Combi,
    Run,
    NewWorkspace,
    NewNamedWorkspace,
    RenameWorkspace,
    SwitchToWorkspace,
    FocusWindow,
}

impl CliRun for Command {
    fn run(&self, sway: &mut swayipc::Connection) -> crate::Result<()> {
        match self {
            Self::Combi => Combi {}.run(sway),
            Self::Run => Run {}.run(sway),
            Self::NewWorkspace => NewWorkspace {}.run(sway),
            Self::NewNamedWorkspace => NewNamedWorkspace {}.run(sway),
            Self::RenameWorkspace => RenameWorkspace {}.run(sway),
            Self::SwitchToWorkspace => SwitchToWorkspace {}.run(sway),
            Self::FocusWindow => FocusWindow {}.run(sway),
        }
    }
}
