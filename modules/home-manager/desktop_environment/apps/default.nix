{pkgs, ...}: {
  imports = [
    ./feh.nix
    ./imv.nix
    ./mpv.nix
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    firefox-private
    gpxsee
  ];
}
