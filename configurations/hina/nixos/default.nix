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
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t470s

    ../../../modules/nixos/base
    ../../../modules/nixos/dan.nix
    ../../../modules/nixos/desktop-environment.nix
    ../../../modules/nixos/peripherals
    ../../../modules/nixos/peripherals/printers/makerspace.nix
    ../../../modules/nixos/ssh.nix
    ../../../modules/nixos/syncthing.nix
    ../../../modules/nixos/tailscale.nix

    {
      networking.hostName = "hina";

      hardware.bluetooth.enable = true;

      # Required for Bambu Lab printer discovery
      networking.firewall.allowedUDPPorts = [2021];
    }
  ];
}
