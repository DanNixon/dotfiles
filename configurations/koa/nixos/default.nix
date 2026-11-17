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
      system.stateVersion = "26.05";

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      # Min 2 GiB, max 4 GiB
      boot.kernelParams = [
        "zfs.zfs_arc_max=4294967296"
        "zfs.zfs_arc_min=2147483648"
      ];

      networking.hostName = "koa";
      networking.hostId = "b1d0f263";

      services.syncthing.enable = true;
    }
  ];
}
