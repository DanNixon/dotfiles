use std::{os::linux::fs::MetadataExt, path::Path};

pub(crate) fn list_programs_from_path() -> Vec<String> {
    std::env::var("PATH")
        .expect("PATH environment variable should be set")
        .split(':')
        .flat_map(|path| match std::fs::read_dir(path) {
            Ok(entries) => Some(entries.into_iter().flat_map(|e| e.ok()).collect::<Vec<_>>()),
            Err(_) => None,
        })
        .flatten()
        .flat_map(|entry| {
            let path = entry.path();
            if path.is_file() && is_executable(&path) {
                path.file_name()
                    .and_then(|v| v.to_str().map(|v| v.to_owned()))
            } else {
                None
            }
        })
        .collect()
}

fn is_executable(path: &Path) -> bool {
    match std::fs::metadata(path) {
        Ok(meta) => (meta.st_mode() & 0o111) != 0,
        Err(_) => false,
    }
}
