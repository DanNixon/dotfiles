{ inputs, lib, config, pkgs, modulesPath, ... }: {
  nixpkgs.overlays = [
    (final: _prev: {
      update-storage = final.callPackage ./update-storage.nix {};
    })
  ];

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    inputs.disko.nixosModules.disko
    ./disk-config.nix

    inputs.sops-nix.nixosModules.sops
    ../common/common.nix
    ../common/dan
    ../common/encrypted-dns.nix
    ../common/locale.nix
    ../common/networkmanager.nix
    ../common/ssh.nix
    ../common/syncthing.nix
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

  users.users.dan.initialPassword = "for-fucks-sake-change-this";

  # Disable gpg-agent, but ensure the directory is present for SSH forwarded socket
  programs.gnupg.agent.enable = false;
  systemd.user.tmpfiles.rules = [ "d %t/gnupg 700 - - -" ];

  environment.systemPackages = with pkgs; [ update-storage ];

  system.stateVersion = "23.05";
}
