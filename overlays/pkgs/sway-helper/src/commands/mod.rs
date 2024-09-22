mod app_run;
mod combi;
mod focus_window;
mod move_window;
mod new_workspace;
mod path_run;
mod rename_workspace;
mod switch_to_workspace;

use self::{
    app_run::AppRun,
    combi::Combi,
    focus_window::FocusWindow,
    move_window::{MoveWindowHere, MoveWindowToWorkspace},
    new_workspace::{NewNamedWorkspace, NewWorkspace},
    path_run::PathRun,
    rename_workspace::RenameWorkspace,
    switch_to_workspace::SwitchToWorkspace,
};
use clap::Subcommand;

pub(crate) trait CliRun {
    fn run(&self, sway: &mut swayipc::Connection) -> crate::Result<()>;
}

#[derive(Debug, Subcommand)]
pub(crate) enum Command {
    Combi,
    AppRun,
    PathRun,
    NewWorkspace,
    NewNamedWorkspace,
    RenameWorkspace,
    SwitchToWorkspace,
    FocusWindow,
    MoveWindowHere,
    MoveWindowToWorkspace,
}

impl CliRun for Command {
    fn run(&self, sway: &mut swayipc::Connection) -> crate::Result<()> {
        match self {
            Self::Combi => Combi {}.run(sway),
            Self::AppRun => AppRun {}.run(sway),
            Self::PathRun => PathRun {}.run(sway),
            Self::NewWorkspace => NewWorkspace {}.run(sway),
            Self::NewNamedWorkspace => NewNamedWorkspace {}.run(sway),
            Self::RenameWorkspace => RenameWorkspace {}.run(sway),
            Self::SwitchToWorkspace => SwitchToWorkspace {}.run(sway),
            Self::FocusWindow => FocusWindow {}.run(sway),
            Self::MoveWindowHere => MoveWindowHere {}.run(sway),
            Self::MoveWindowToWorkspace => MoveWindowToWorkspace {}.run(sway),
        }
    }
}
