{pkgs, ...}: {
  imports = [
    ./imv.nix
    ./mpv.nix
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    gpxsee
  ];

  services.flatpak.packages = [
    "net.ankiweb.Anki"
    "org.gnome.Calculator"
    "org.gnome.Evince"
  ];
}
