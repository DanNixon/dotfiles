{
  inputs,
  outputs,
}:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {inherit inputs outputs;};

  modules = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    inputs.sops-nix.nixosModules.sops
    ../../../modules/nixos/base
    ../../../modules/nixos/dan
    ../../../modules/nixos/dan/secrets
    ../../../modules/nixos/desktop-environment.nix
    ../../../modules/nixos/dnscrypt-proxy.nix
    ../../../modules/nixos/networkmanager.nix
    ../../../modules/nixos/peripherals/adb.nix
    ../../../modules/nixos/peripherals/printers
    ../../../modules/nixos/peripherals/printers/makerspace.nix
    ../../../modules/nixos/peripherals/probe-rs.nix
    ../../../modules/nixos/peripherals/sound.nix
    ../../../modules/nixos/peripherals/sdr.nix
    ../../../modules/nixos/ssh.nix
    ../../../modules/nixos/syncthing.nix

    {
      boot = {
        loader.systemd-boot.enable = true;
        loader.efi.canTouchEfiVariables = true;
        initrd.secrets."/crypto_keyfile.bin" = null;
      };

      networking.hostName = "kawashiro";

      services.dnscrypt-proxy2.settings.forwarding_rules = "/etc/dnscrypt-proxy2/forwarding-rules.txt";
      environment.etc."dnscrypt-proxy2/forwarding-rules.txt".text = ''
        castle.dan-nixon.com 100.103.214.89
      '';

      virtualisation.podman.enable = true;
      services.upower.enable = true;
      services.tailscale.enable = true;

      dotfiles.dan.groups = ["video" "dialout"];

      # Required for Bambu Lab printer discovery
      networking.firewall.allowedUDPPorts = [2021];
    }
  ];
}
