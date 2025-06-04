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
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x230
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ../../../modules/nixos/base
    ../../../modules/nixos/dan.nix
    ../../../modules/nixos/desktop-environment.nix
    ../../../modules/nixos/dnscrypt-proxy.nix
    ../../../modules/nixos/networkmanager.nix
    ../../../modules/nixos/peripherals/adb.nix
    ../../../modules/nixos/peripherals/keyboard.nix
    ../../../modules/nixos/peripherals/printers/makerspace.nix
    ../../../modules/nixos/peripherals/probe-rs.nix
    ../../../modules/nixos/peripherals/sound.nix
    ../../../modules/nixos/peripherals/yubikey.nix
    ../../../modules/nixos/ssh.nix

    {
      networking.hostName = "akane";

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

      dotfiles.dan.groups = ["video" "dialout"];

      # Required for Bambu Lab printer discovery
      networking.firewall.allowedUDPPorts = [2021];

      # Label printer
      services.udev.extraRules = ''
        ACTION=="add", SUBSYSTEMS=="usb", ATTRS{idVendor}=="0922", ATTRS{idProduct}=="1001", MODE="0666"
        ACTION=="add", SUBSYSTEMS=="usb", ATTRS{idVendor}=="0922", ATTRS{idProduct}=="0015", MODE="0666"
      '';
    }
  ];
}
