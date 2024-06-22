{pkgs, ...}: {
  hardware.graphics.enable = true;

  fonts = {
    fontDir.enable = true;

    packages = with pkgs; [
      (nerdfonts.override {fonts = ["DejaVuSansMono"];})
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
}
