# Flatpak

## Font setup

```sh
flatpak --user override --filesystem=$HOME/.local/share/fonts
flatpak --user override --filesystem=/nix/store
```

## App specific config

### Chromium

Navigate to `chrome://flags/#ozone-platform-hint` and set to `Auto` or `Wayland` to enable Wayland.
Optionally then disable X11 for `org.chromium.Chromium`.
