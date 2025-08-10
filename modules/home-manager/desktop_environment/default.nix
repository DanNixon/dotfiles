{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./alacritty.nix
  ];

  home.packages = with pkgs; [
    ddcutil
    ddcui
    headsetcontrol
    labelle # Label printer
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
        video = ["io.mpv.Mpv.desktop" "org.videolan.VLC.desktop"];
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

        "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
      };
    };
  };

  # COSMIC config files
  xdg.configFile."cosmic" = {
    source = ./cosmic_config;
    recursive = true;
  };

  programs.zathura.enable = true;

  home.file.".var/app/io.mpv.Mpv/config/mpv/input.conf".text = ''
    h seek -5
    j seek 60
    k seek -60
    l seek 5

    # Make shift-j cycle subtitles normally (since j is used for Vi style transport)
    J cycle sub
  '';

  programs.imv.enable = true;
  xdg.configFile."imv/config".text = ''
    [binds]
    h = prev
    j = next
    k = prev
    l = next

    <Shift+H> = pan 50 0
    <Shift+J> = pan 0 -50
    <Shift+K> = pan 0 50
    <Shift+L> = pan -50 0
  '';
}
