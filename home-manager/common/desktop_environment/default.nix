{ config, pkgs, ... }: {
  imports = [
    ./components/alacritty.nix
    ./components/mako.nix
    ./components/sway.nix
    ./components/tofi.nix
    ./components/warpd.nix

    ./apps
  ];

  home.packages = with pkgs; [
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
        multimedia = [ "mpv.desktop" "org.videolan.VLC.desktop" ];
      in {
        "video/3gpp" = multimedia;
        "video/mp4" = multimedia;
        "video/x-matroska" = multimedia;
        "video/x-msvideo" = multimedia;
      };
    };
  };
}