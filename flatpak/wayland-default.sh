#!/usr/bin/env sh

flatpak --user override \
    --socket=wayland \
    --nosocket=x11 \
    --nosocket=fallback-x11
