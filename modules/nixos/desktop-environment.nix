{pkgs, ...}: {
  services.displayManager.cosmic-greeter.enable = true;

  services.desktopManager.cosmic = {
    enable = true;
    xwayland.enable = true;
  };

  fonts = {
    fontDir.enable = true;

    packages = with pkgs; [
      nerd-fonts.dejavu-sans-mono
    ];
  };

  services.flatpak.enable = true;

  services.udisks2.enable = true;

  # https://github.com/NixOS/nixpkgs/issues/259641#issuecomment-2910335440
  services.geoclue2.enable = true;

  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = "1";
}
