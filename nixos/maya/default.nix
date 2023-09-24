{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.sops-nix.nixosModules.sops
    ../common/common.nix
    ../common/dan
    ../common/dan/secrets
    ../common/desktop-environment.nix
    ../common/encrypted-dns.nix
    ../common/locale.nix
    ../common/networkmanager.nix
    ../common/sound.nix
    ../common/ssh.nix
    ../common/syncthing.nix
  ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    initrd.secrets."/crypto_keyfile.bin" = null;
  };

  networking.hostName = "maya";

  virtualisation.podman.enable = true;
  services.upower.enable = true;
  services.tailscale.enable = true;

  # i2c required for monitor control via ddcutil
  hardware.i2c.enable = true;
  users.users.dan.extraGroups = [ "i2c" "dialout" "plugdev" ];

  system.stateVersion = "23.05";
}
