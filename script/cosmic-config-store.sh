#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

DEST="${SCRIPT_DIR}/../modules/home-manager/config/"
SRC="${XDG_CONFIG_HOME}/cosmic"

cp -r "$SRC" "$DEST"
