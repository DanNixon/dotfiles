{
  inputs,
  outputs,
}:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {inherit inputs outputs;};

  modules = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ../../../modules/nixos/base
    ../../../modules/nixos/dan.nix
    ../../../modules/nixos/desktop-environment.nix
    ../../../modules/nixos/peripherals
    ../../../modules/nixos/peripherals/printers/home.nix
    ../../../modules/nixos/ssh.nix
    ../../../modules/nixos/syncthing.nix
    ../../../modules/nixos/tailscale.nix

    ({...}: {
      boot = {
        loader.systemd-boot.enable = true;
        loader.efi.canTouchEfiVariables = true;
        initrd.secrets."/crypto_keyfile.bin" = null;
      };

      networking.hostName = "maya";

      networking.extraHosts = ''
        130.246.53.247 ndw2982.isis.cclrc.ac.uk
      '';
    })
  ];
}
