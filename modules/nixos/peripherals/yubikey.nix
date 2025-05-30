{...}: {
  services.pcscd.enable = true;
  services.yubikey-agent.enable = true;
  programs.yubikey-touch-detector.enable = true;
}
