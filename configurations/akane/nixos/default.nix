{
  inputs,
  outputs,
}:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {inherit inputs outputs;};

  modules = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x230
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    inputs.sops-nix.nixosModules.sops
    ../../../modules/nixos/adb.nix
    ../../../modules/nixos/base.nix
    ../../../modules/nixos/dan
    ../../../modules/nixos/dan/secrets
    ../../../modules/nixos/desktop-environment.nix
    ../../../modules/nixos/encrypted-dns.nix
    ../../../modules/nixos/locale.nix
    ../../../modules/nixos/networkmanager.nix
    ../../../modules/nixos/scanner.nix
    ../../../modules/nixos/sound.nix
    ../../../modules/nixos/ssh.nix
    ../../../modules/nixos/syncthing.nix

    {
      boot = {
        loader.systemd-boot.enable = true;
        loader.efi.canTouchEfiVariables = true;
        initrd.secrets."/crypto_keyfile.bin" = null;
      };

      networking.hostName = "akane";

      users.users.dan.extraGroups = ["dialout"];

      virtualisation.podman.enable = true;
      services.upower.enable = true;
      services.tailscale.enable = true;
    }
  ];
}
