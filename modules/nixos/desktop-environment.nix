{pkgs, ...}: {
  fonts = {
    fontDir.enable = true;

    fonts = with pkgs; [
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

  programs.light.enable = true;

  programs.sway.enable = true;

  services.udisks2.enable = true;
}
