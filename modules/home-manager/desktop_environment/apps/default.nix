{pkgs, ...}: {
  imports = [
    ./feh.nix
    ./imv.nix
    ./mpv.nix
    ./vscode.nix
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    firefox-private
    gpxsee
  ];
}
