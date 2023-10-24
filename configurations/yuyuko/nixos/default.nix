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
    ./disk-config.nix

    ../../../modules/nixos/base
    ../../../modules/nixos/dan
    ../../../modules/nixos/desktop-environment.nix
    ../../../modules/nixos/dnscrypt-proxy.nix
    ../../../modules/nixos/networkmanager.nix
    ../../../modules/nixos/peripherals/sound.nix
    ../../../modules/nixos/ssh.nix

    {
      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      nixpkgs.hostPlatform = "x86_64-linux";

      networking.hostName = "yuyuko";

      users.users.dan.initialPassword = "for-fucks-sake-change-this";
    }
  ];
}
