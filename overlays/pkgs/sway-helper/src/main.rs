#![deny(clippy::unwrap_used)]

mod commands;
mod error;
mod helpers;

use self::{
    commands::CliRun,
    error::{Error, Result},
};
use clap::Parser;

#[derive(Debug, Parser)]
struct Cli {
    #[clap(subcommand)]
    command: self::commands::Command,
}

fn main() -> crate::Result<()> {
    let cli = Cli::parse();
    let mut sway = swayipc::Connection::new()?;
    cli.command.run(&mut sway)
}
