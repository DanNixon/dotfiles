{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./alacritty.nix
    ./imv.nix
    ./mpv.nix
    ./zathura.nix
  ];

  services.flatpak = {
    enable = true;

    packages = [
      "org.mozilla.firefox"
      "com.github.tchx84.Flatseal"

      "net.werwolv.ImHex"

      "org.gimp.GIMP"
      "org.inkscape.Inkscape"

      "org.musicbrainz.Picard"
      "org.videolan.VLC"

      "org.libreoffice.LibreOffice"
      "com.jgraph.drawio.desktop"

      "org.kicad.KiCad"
      "org.freecadweb.FreeCAD"
      "org.librecad.librecad"
      "org.openscad.OpenSCAD"
      "com.bambulab.BambuStudio"

      "org.rncbc.qpwgraph"

      "net.ankiweb.Anki"
      "org.gnome.Calculator"

      "app.organicmaps.desktop"
      "nl.sarine.gpx-viewer"
    ];
  };

  home.packages = with pkgs; [
    ddcutil
    ddcui
    headsetcontrol
    wdisplays
    wl-clipboard
    xdg-utils
  ];

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;

      desktop = null;
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      music = lib.mkDefault null;
      pictures = null;
      publicShare = null;
      templates = null;
      videos = null;
    };

    mime.enable = true;
    mimeApps = {
      enable = true;

      defaultApplications = let
        image = ["imv.desktop"];
        video = ["mpv.desktop" "org.videolan.VLC.desktop"];
      in {
        "image/bmp" = image;
        "image/jpeg" = image;
        "image/jpg" = image;
        "image/png" = image;
        "image/webp" = image;
        "image/gif" = image;

        "video/3gpp" = video;
        "video/mp4" = video;
        "video/webm" = video;
        "video/x-matroska" = video;
        "video/x-msvideo" = video;
      };
    };
  };

  # Required for Flatpak apps to have access to system fonts
  # TODO: is this still needed?
  home.file.fonts = {
    target = ".local/share/fonts";
    source = config.lib.file.mkOutOfStoreSymlink "/run/current-system/sw/share/X11/fonts";
  };

  # COSMIC config files
  xdg.configFile."cosmic" = {
    source = ./cosmic_config;
    recursive = true;
  };
}
