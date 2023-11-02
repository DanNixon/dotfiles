{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./components/alacritty.nix
    ./components/mako.nix
    ./components/sway.nix
    ./components/tofi.nix
    ./components/warpd.nix

    ./apps
  ];

  home.packages = with pkgs; [
    ddcutil
    ddcui
    de-screenshot
    headsetcontrol
    wdisplays
    wl-clipboard
    yubikey-touch-detector
    xdg-utils
  ];

  xdg = {
    mime.enable = true;

    mimeApps = {
      enable = true;

      defaultApplications = let
        image = ["feh.desktop"];
        video = ["mpv.desktop" "org.videolan.VLC.desktop"];
      in {
        "image/bmp" = image;
        "image/gif" = image;
        "image/jpeg" = image;
        "image/jpg" = image;
        "image/pjpeg" = image;
        "image/png" = image;
        "image/tiff" = image;
        "image/x-bmp" = image;
        "image/x-pcx" = image;
        "image/x-png" = image;
        "image/x-portable-anymap" = image;
        "image/x-portable-bitmap" = image;
        "image/x-portable-graymap" = image;
        "image/x-portable-pixmap" = image;
        "image/x-tga" = image;
        "image/x-xbitmap" = image;
        "image/heif" = image;

        "video/3gpp" = video;
        "video/mp4" = video;
        "video/webm" = video;
        "video/x-matroska" = video;
        "video/x-msvideo" = video;
      };
    };
  };

  # Required for Flatpak apps to have access to system fonts
  home.file.fonts = {
    target = ".local/share/fonts";
    source = config.lib.file.mkOutOfStoreSymlink "/run/current-system/sw/share/X11/fonts";
  };
}
