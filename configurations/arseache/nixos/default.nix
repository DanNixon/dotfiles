{
  inputs,
  outputs,
}:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {inherit inputs outputs;};

  modules = [
    ./hardware-configuration.nix
    inputs.disko.nixosModules.disko
    ./disk-config.nix

    ../../../modules/nixos

    {
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "arseache";
      networking.hostId = "88a22c92";
    }
  ];
}
