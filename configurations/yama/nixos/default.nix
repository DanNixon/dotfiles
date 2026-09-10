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
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd

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

      networking.hostName = "yama";
      networking.hostId = "9f04a798";

      services.syncthing.enable = true;

      # Required for Bambu Lab printer discovery
      networking.firewall.allowedUDPPorts = [2021];
    }
  ];
}
