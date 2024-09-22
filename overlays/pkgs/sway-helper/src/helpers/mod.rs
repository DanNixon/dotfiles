pub(crate) mod freedesktop;
pub(crate) mod programs;
pub(crate) mod sway;

use fzf_wrapped::FzfBuilder;

pub(crate) fn run_fzf<T: IntoIterator<Item = impl Into<String>>>(
    prompt: &str,
    items: T,
) -> crate::Result<String> {
    let mut fzf = FzfBuilder::default()
        .layout(fzf_wrapped::Layout::Reverse)
        .prompt(format!("{prompt}> "))
        .cycle(true)
        .custom_args(vec!["--bind=tab:down,shift-tab:up", "--ansi"])
        .build()?;

    fzf.run().map_err(crate::Error::Fzf)?;

    fzf.add_items(items).map_err(crate::Error::Fzf)?;

    match fzf.output() {
        Some(selection) => {
            if selection.trim().is_empty() {
                Err(crate::Error::NoSelectionMade)
            } else {
                Ok(selection)
            }
        }
        None => Err(crate::Error::NoSelectionMade),
    }
}

pub(crate) fn edit_single_line(s: &str) -> crate::Result<String> {
    let name = edit::edit(s).map_err(crate::Error::Editor)?;
    let name = name.trim();
    Ok(name.to_string())
}
