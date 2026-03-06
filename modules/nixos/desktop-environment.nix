{pkgs, ...}: {
  services.displayManager.cosmic-greeter.enable = true;

  services.desktopManager.cosmic = {
    enable = true;
    xwayland.enable = true;
  };

  environment.cosmic.excludePackages = with pkgs; [
    cosmic-edit
    cosmic-player
    cosmic-term
  ];

  fonts = {
    fontDir.enable = true;

    packages = with pkgs; [
      nerd-fonts.dejavu-sans-mono
    ];
  };

  services.flatpak.enable = true;

  services.udisks2.enable = true;

  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = "1";

  environment.systemPackages = with pkgs; [
    alacritty
  ];

  systemd.user.sockets.gcr-ssh-agent.enable = false;
  systemd.user.services.gcr-ssh-agent.enable = false;
}
