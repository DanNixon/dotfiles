{
  inputs,
  outputs,
}:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {inherit inputs outputs;};

  modules = [
    inputs.disko.nixosModules.disko
    ({modulesPath, ...}: {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];
    })
    ./hardware.nix
    ./disk-config.nix
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd

    ../../../modules/nixos/base
    ../../../modules/nixos/dan.nix
    ../../../modules/nixos/desktop-environment.nix
    ../../../modules/nixos/peripherals
    ../../../modules/nixos/peripherals/printers/home.nix
    ../../../modules/nixos/ssh.nix
    ../../../modules/nixos/syncthing.nix
    ../../../modules/nixos/tailscale.nix

    {
      networking.hostName = "yama";

      hardware.bluetooth.enable = true;
    }
  ];
}
