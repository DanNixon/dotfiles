{pkgs, ...}: {
  fonts = {
    fontDir.enable = true;

    packages = with pkgs; [
      nerd-fonts.dejavu-sans-mono
    ];
  };

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  services.flatpak.enable = true;

  programs.sway.enable = true;

  services.udisks2.enable = true;

  services.displayManager.cosmic-greeter.enable = true;

  services.desktopManager.cosmic = {
    enable = true;
    xwayland.enable = true;
  };

  # https://github.com/NixOS/nixpkgs/issues/259641#issuecomment-2910335440
  services.geoclue2.enable = true;
}
