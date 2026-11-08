#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

SRC="${SCRIPT_DIR}/../xdg_config/cosmic/"
DEST="${XDG_CONFIG_HOME}/"

cp -r "$SRC" "$DEST"
