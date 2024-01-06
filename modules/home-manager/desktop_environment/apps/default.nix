{pkgs, ...}: {
  imports = [
    ./feh.nix
    ./imv.nix
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    firefox-private
    gpxsee
  ];
}
