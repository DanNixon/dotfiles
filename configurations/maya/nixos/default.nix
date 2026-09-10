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
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ../../../modules/nixos

    ({
      lib,
      config,
      ...
    }: {
      system.stateVersion = "26.05";

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      # Min 2 GiB, max 4 GiB
      boot.kernelParams = [
        "zfs.zfs_arc_max=4294967296"
        "zfs.zfs_arc_min=2147483648"
      ];

      networking.hostName = "maya";
      networking.hostId = "4bed7e12";

      hardware.graphics.enable = true;
      services.xserver.videoDrivers = ["nvidia"];
      hardware.nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
        open = lib.mkForce false;
        modesetting.enable = true;
        powerManagement.enable = false;
        nvidiaSettings = true;
      };

      services.syncthing.enable = true;

      networking.extraHosts = ''
        130.246.81.219 grafana.observability.isis.rl.ac.uk
        130.246.53.247 ndw2982.isis.cclrc.ac.uk
      '';
    })
  ];
}
