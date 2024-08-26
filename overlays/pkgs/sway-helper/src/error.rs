#[derive(Debug, thiserror::Error)]
pub(crate) enum Error {
    #[error("Sway IPC error: {0}")]
    SwayIpc(#[from] swayipc::Error),

    #[error("Failed to run editor: {0}")]
    Editor(std::io::Error),

    #[error("Failed to build Fzf wrapper: {0}")]
    FzfBuilder(#[from] fzf_wrapped::FzfBuilderError),

    #[error("Failed to run Fzf: {0}")]
    Fzf(std::io::Error),

    #[error("No selectoin has been made")]
    NoSelectionMade,

    #[error("Invalid input provided in window focus mode: {0}")]
    WindowInvalidInput(String),

    #[error("Invalid input provided in combi mode: {0}")]
    CombiInvalidInput(String),
}

pub(crate) type Result<T> = std::result::Result<T, Error>;