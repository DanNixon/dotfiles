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
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t470s

    ../../../modules/nixos

    {
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "hina";
      networking.hostId = "88a22c95";

      services.syncthing.enable = true;
    }
  ];
}
