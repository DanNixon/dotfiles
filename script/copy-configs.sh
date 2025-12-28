#!/usr/bin/env bash
# Copies the plain config files to the correct locations.

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

CONFIG_FILES=(
    "fish/config.fish"
    "fish/functions/fish_bind_count.fish"
    "fish/functions/fish_default_mode_prompt.fish"
    "fish/functions/fish_helix_command.fish"
    "fish/functions/fish_helix_key_bindings.fish"
    "fish/functions/fish_prompt.fish"
    "git/attributes"
    "git/config"
    "helix/config.toml"
)

for config_rel_path in "${CONFIG_FILES[@]}"; do
    full_repo_path="${SCRIPT_DIR}/../modules/home-manager/config/${config_rel_path}"
    local_path="$HOME/.config/${config_rel_path}"
    
    mkdir -p "$(dirname "$local_path")"
    cp "$full_repo_path" "$local_path"
done
