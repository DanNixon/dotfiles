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
        (modulesPath + "/profiles/qemu-guest.nix")
      ];
    })
    ./disk-config.nix

    ../../../modules/nixos/base
    ../../../modules/nixos/dan.nix
    ../../../modules/nixos/dnscrypt-proxy.nix
    ../../../modules/nixos/networkmanager.nix
    ../../../modules/nixos/ssh.nix
    ../../../modules/nixos/syncthing.nix

    ({pkgs, ...}: {
      nixpkgs.overlays = [
        (final: _prev: {
          update-storage = final.callPackage ./update-storage.nix {};
        })
      ];

      boot.loader.grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
      };

      nixpkgs.hostPlatform = "x86_64-linux";

      networking.hostName = "yukari";

      networking.firewall.extraInputRules = ''
        iifname "tailscale0" tcp dport 22 log prefix "firewall: new SSH connection: " counter accept
        iifname "tailscale0" tcp dport 22000 log prefix "firewall: Syncthing: " counter accept
        iifname "tailscale0" udp dport 22000 log prefix "firewall: Syncthing: " counter accept
        iifname "tailscale0" udp dport 21027 log prefix "firewall: Syncthing: " counter accept
      '';
      services.openssh.openFirewall = false;
      services.syncthing.openDefaultPorts = false;

      services.tailscale.enable = true;

      dotfiles.dan.initialPassword = "for-fucks-sake-change-this";

      # Disable gpg-agent, but ensure the directory is present for SSH forwarded socket
      dotfiles.dan.enableGpgAgent = false;
      systemd.user.tmpfiles.rules = ["d %t/gnupg 700 - - -"];

      environment.systemPackages = with pkgs; [update-storage];
    })
  ];
}
