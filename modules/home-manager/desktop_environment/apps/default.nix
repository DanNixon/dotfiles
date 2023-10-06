{pkgs, ...}: {
  imports = [
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    firefox-private
    gpxsee
  ];
}
