# Flatpak

## Setup

- `./setup.sh`
- Select apps in `install-apps.sh`
- `./install-apps.sh`

## App specific config

### Chromium

Navigate to `chrome://flags/#ozone-platform-hint` and set to `Auto` or `Wayland` to enable Wayland.
Optionally then disable X11 for `org.chromium.Chromium`.
