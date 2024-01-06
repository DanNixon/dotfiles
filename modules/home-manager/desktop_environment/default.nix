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
        "image/jpeg" = image;
        "image/jpg" = image;
        "image/png" = image;
        "image/webp" = image;

        "image/gif" = video;
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
