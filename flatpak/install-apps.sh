#!/usr/bin/env bash

set -exo pipefail

flatpak install \
  org.mozilla.firefox \
  org.chromium.Chromium \
  com.microsoft.Edge \
  com.github.Eloston.UngoogledChromium \
  org.kicad.KiCad \
  org.freecadweb.FreeCAD \
  org.librecad.librecad \
  org.openscad.OpenSCAD \
  com.prusa3d.PrusaSlicer \
  org.gimp.GIMP \
  org.inkscape.Inkscape \
  org.videolan.VLC \
  org.musicbrainz.Picard \
  im.riot.Riot \
  us.zoom.Zoom \
  org.libreoffice.LibreOffice \
  com.jgraph.drawio.desktop \
  com.github.flxzt.rnote \
  com.github.tchx84.Flatseal \
  org.rncbc.qpwgraph \
  org.remmina.Remmina \
  com.vesc_project.VescTool \
  com.valvesoftware.Steam
