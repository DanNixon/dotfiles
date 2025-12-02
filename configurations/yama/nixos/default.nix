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

    ../../../modules/nixos
    ../../../modules/nixos/printers/home.nix

    {
      networking.hostName = "yama";

      services.syncthing.enable = true;
    }
  ];
}
