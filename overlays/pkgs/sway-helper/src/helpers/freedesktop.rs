use crate::helpers::sway::run_program;
use regex::Regex;

pub(crate) fn find_all_freedesktop_app_launchables() -> Vec<String> {
    let locales = freedesktop_desktop_entry::get_languages_from_env();

    freedesktop_desktop_entry::Iter::new(freedesktop_desktop_entry::default_paths())
        .entries(Some(&locales))
        .flat_map(|entry| {
            let entry_name = entry.name(&locales).unwrap_or_else(|| entry.appid.clone());

            let mut launchables = vec![format!("{} ({})", entry_name, entry.appid)];

            if let Some(actions) = entry.actions() {
                launchables.extend(actions.iter().flat_map(|action_id| {
                    if action_id.is_empty() {
                        None
                    } else {
                        match entry.action_name(action_id, &locales) {
                            Some(name) => {
                                Some(format!("{} > {} ({})", entry_name, name, entry.appid))
                            }
                            None => None,
                        }
                    }
                }));
            }

            launchables
        })
        .collect()
}

pub(crate) fn parse_freedesktop_app_and_action(
    selected: &str,
) -> crate::Result<(String, Option<String>)> {
    let a = Regex::new(r".+ > ([\w\s]+) \(([\w\.]+)\)$").expect("regex expression should be valid");
    let b = Regex::new(r".+ \(([\w\.]+)\)$").expect("regex expression should be valid");

    match a.captures(selected) {
        Some(captures) => Ok((captures[2].to_string(), Some(captures[1].to_string()))),
        None => match b.captures(selected) {
            Some(captures) => Ok((captures[1].to_string(), None)),
            None => Err(crate::Error::AppRunInvalidInput("".to_string())),
        },
    }
}

pub(crate) fn launch_freedesktop_app(
    sway: &mut swayipc::Connection,
    app_id: String,
    action: Option<String>,
) -> crate::Result<()> {
    let locales = freedesktop_desktop_entry::get_languages_from_env();

    let entries: Vec<_> =
        freedesktop_desktop_entry::Iter::new(freedesktop_desktop_entry::default_paths())
            .entries(Some(&locales))
            .collect();
    let entries = entries.iter();

    let entry = freedesktop_desktop_entry::matching::find_entry_from_appid(entries, &app_id)
        .ok_or_else(|| crate::Error::AppWithIdNotFound(app_id.clone()))?;

    let exec = match action {
        Some(action) => {
            let actions = entry
                .actions()
                .ok_or_else(|| crate::Error::AppHasNoActions(app_id.clone()))?;

            let action_id = actions
                .iter()
                .find(|id| match entry.action_name(id, &locales) {
                    Some(a) => a == action,
                    None => false,
                })
                .ok_or_else(|| crate::Error::AppHasNoAction(app_id.clone(), action))?;

            entry.parse_exec_action(action_id)
        }
        None => entry.parse_exec(),
    };

    let program = exec
        .map_err(|_| crate::Error::AppHasMalformedExec(app_id))?
        .join(" ");

    run_program(sway, &program)
}
