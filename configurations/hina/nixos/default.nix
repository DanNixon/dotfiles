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
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t470s

    ../../../modules/nixos/base
    ../../../modules/nixos/dan.nix
    ../../../modules/nixos/desktop-environment.nix
    ../../../modules/nixos/peripherals/label-printers.nix
    ../../../modules/nixos/peripherals/printers/makerspace.nix
    ../../../modules/nixos/peripherals/probe-rs.nix
    ../../../modules/nixos/peripherals/scanner.nix
    ../../../modules/nixos/peripherals/yubikey.nix
    ../../../modules/nixos/ssh.nix

    {
      networking.hostName = "hina";

      services.dnscrypt-proxy2.settings.forwarding_rules = "/etc/dnscrypt-proxy2/forwarding-rules.txt";
      environment.etc."dnscrypt-proxy2/forwarding-rules.txt".text = ''
        castle.dan-nixon.com 100.65.23.56
      '';

      hardware.bluetooth.enable = true;
      services.upower.enable = true;
      virtualisation.podman.enable = true;

      services.tailscale = {
        enable = true;
        useRoutingFeatures = "client";
      };

      dotfiles.dan.groups = ["video" "dialout" "plugdev"];

      # Required for Bambu Lab printer discovery
      networking.firewall.allowedUDPPorts = [2021];
    }
  ];
}
