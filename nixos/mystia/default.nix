{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../common/common.nix
    ../common/dan.nix
    ../common/desktop-environment.nix
    ../common/encrypted-dns.nix
    ../common/locale.nix
    ../common/networkmanager.nix
    ../common/sound.nix
    ../common/ssh.nix
  ];

  boot = {
    loader.grub.enable = true;
    loader.grub.device = "/dev/sda";
    loader.grub.useOSProber = false;
    initrd.secrets."/crypto_keyfile.bin" = null;
    loader.grub.enableCryptodisk = true;
    initrd.luks.devices."luks-bb576575-6142-43b1-a26f-c4ae199eb259".keyFile = "/crypto_keyfile.bin";
  };

  networking.hostName = "mystia";

  virtualisation.podman.enable = true;
  services.upower.enable = true;
  services.tailscale.enable = true;

  system.stateVersion = "23.05";
}
