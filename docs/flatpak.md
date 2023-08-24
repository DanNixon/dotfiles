# Flatpak

## Setup

```sh
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update
```

To get fonts to render correctly:
```sh
ln -s /run/current-system/sw/share/X11/fonts ~/.local/share/fonts
flatpak --user override --filesystem=$HOME/.local/share/fonts
flatpak --user override --filesystem=/nix/store
```

## Apps

- `org.videolan.VLC`
- `org.kicad.KiCad`
- `org.freecadweb.FreeCAD`
- `com.prusa3d.PrusaSlicer`
- `org.librecad.librecad`
- `org.openscad.OpenSCAD`
- `org.libreoffice.LibreOffice`
- `org.gimp.GIMP`
- `org.inkscape.Inkscape`
- `org.mozilla.firefox`
- `org.chromium.Chromium`
- `com.github.Eloston.UngoogledChromium`
- `com.github.tchx84.Flatseal`
- `org.remmina.Remmina`
- `org.rncbc.qpwgraph`
- `us.zoom.Zoom`
- `com.vesc_project.VescTool`
- `com.github.flxzt.rnote`
- `im.riot.Riot`
- `org.musicbrainz.Picard`
- `com.jgraph.drawio.desktop`
- `com.valvesoftware.Steam`

## App specific config

### Chromium

Navigate to `chrome://flags/#ozone-platform-hint` and set to `Auto` or `Wayland` to enable Wayland.
Optionally then disable X11 for `org.chromium.Chromium`.
