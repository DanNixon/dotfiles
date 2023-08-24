{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    ../common/common.nix
    ../common/dan.nix
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

  networking.hostName = "kawashiro";

  users.users.dan.extraGroups = [ "dialout" "plugdev" ];

  virtualisation.podman.enable = true;
  services.upower.enable = true;
  services.tailscale.enable = true;

  hardware.rtl-sdr.enable = true;

  system.stateVersion = "23.05";
}
