{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    ddcutil
    ddcui
    headsetcontrol
    labelle # Label printer
    wl-clipboard
    xdg-utils
  ];
  programs.zathura.enable = true;
  programs.imv.enable = true;

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;

      desktop = null;
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/music";
      pictures = null;
      projects = null;
      publicShare = null;
      templates = null;
      videos = null;
    };

    mime.enable = true;
    mimeApps = {
      enable = true;

      defaultApplications = let
        web = ["org.mozilla.firefox.desktop"];
        image = ["imv.desktop"];
        video = ["io.mpv.Mpv.desktop" "org.videolan.VLC.desktop"];
      in {
        "text/html" = web;
        "x-scheme-handler/http" = web;
        "x-scheme-handler/https" = web;
        "x-scheme-handler/about" = web;
        "x-scheme-handler/unknown" = web;

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
}
