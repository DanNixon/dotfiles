{
  inputs,
  outputs,
}:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {inherit inputs outputs;};

  modules = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ../../../modules/nixos

    ({...}: {
      boot = {
        loader.systemd-boot.enable = true;
        loader.efi.canTouchEfiVariables = true;
        initrd.secrets."/crypto_keyfile.bin" = null;
      };

      networking.hostName = "maya";

      services.syncthing.enable = true;

      networking.extraHosts = ''
        130.246.53.247 ndw2982.isis.cclrc.ac.uk
      '';
    })
  ];
}
