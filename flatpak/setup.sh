#!/usr/bin/env bash

set -exo pipefail

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update

# Make system fonts available
flatpak --user override --filesystem=$HOME/.local/share/fonts
flatpak --user override --filesystem=/nix/store
