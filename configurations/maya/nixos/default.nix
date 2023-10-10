{
  inputs,
  outputs,
}:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {inherit inputs outputs;};

  modules = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    inputs.sops-nix.nixosModules.sops
    ../../../modules/nixos/base.nix
    ../../../modules/nixos/dan
    ../../../modules/nixos/dan/secrets
    ../../../modules/nixos/desktop-environment.nix
    ../../../modules/nixos/dnscrypt-proxy.nix
    ../../../modules/nixos/locale.nix
    ../../../modules/nixos/networkmanager.nix
    ../../../modules/nixos/sound.nix
    ../../../modules/nixos/ssh.nix
    ../../../modules/nixos/syncthing.nix

    {
      boot = {
        loader.systemd-boot.enable = true;
        loader.efi.canTouchEfiVariables = true;
        initrd.secrets."/crypto_keyfile.bin" = null;
      };

      networking.hostName = "maya";

      services.dnscrypt-proxy2.settings.forwarding_rules = "/etc/dnscrypt-proxy2/forwarding-rules.txt";
      environment.etc."dnscrypt-proxy2/forwarding-rules.txt".text = ''
        castle.dan-nixon.com 100.71.249.35
      '';

      virtualisation.podman.enable = true;
      services.upower.enable = true;
      services.tailscale.enable = true;

      # i2c required for monitor control via ddcutil
      hardware.i2c.enable = true;
      users.users.dan.extraGroups = ["i2c" "dialout" "plugdev"];
    }
  ];
}
