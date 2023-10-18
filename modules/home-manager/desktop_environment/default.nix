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
        multimedia = ["mpv.desktop" "org.videolan.VLC.desktop"];
      in {
        "image/gif" = multimedia;
        "video/3gpp" = multimedia;
        "video/mp4" = multimedia;
        "video/webm" = multimedia;
        "video/x-matroska" = multimedia;
        "video/x-msvideo" = multimedia;
      };
    };
  };

  # Required for Flatpak apps to have access to system fonts
  home.file.fonts = {
    target = ".local/share/fonts";
    source = config.lib.file.mkOutOfStoreSymlink "/run/current-system/sw/share/X11/fonts";
  };
}
