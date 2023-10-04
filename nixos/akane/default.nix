{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x230
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    inputs.sops-nix.nixosModules.sops
    ../common/adb.nix
    ../common/base.nix
    ../common/dan
    ../common/dan/secrets
    ../common/desktop-environment.nix
    ../common/encrypted-dns.nix
    ../common/locale.nix
    ../common/networkmanager.nix
    ../common/scanner.nix
    ../common/sound.nix
    ../common/ssh.nix
    ../common/syncthing.nix
  ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    initrd.secrets."/crypto_keyfile.bin" = null;
  };

  networking.hostName = "akane";

  users.users.dan.extraGroups = [ "dialout" ];

  virtualisation.podman.enable = true;
  services.upower.enable = true;
  services.tailscale.enable = true;
}
