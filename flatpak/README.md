# Flatpak

## App specific configuration

### Firefox

- Ensure `socket=x11` and `socket=fallback-x11` are disabled
- Navigate to `about:support` and look for *Window Protocol* to verify Wayland is in use

### Chromium

- Ensure `socket=x11` and `socket=fallback-x11` are disabled
- Navigate to `chrome://flags/#ozone-platform-hint` and set to *Wayland*
