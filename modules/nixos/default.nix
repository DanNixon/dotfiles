{
  inputs,
  outputs,
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./dan.nix
    ./desktop-environment.nix
    ./keyboard.nix
    ./locale.nix
    ./networking.nix
    ./peripherals.nix
    ./sound.nix
    ./ssh.nix
    ./syncthing.nix
  ];

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
  };

  nixpkgs = {
    config.allowUnfree = true;

    overlays = [
      outputs.overlays.additions
    ];
  };

  hardware.enableRedistributableFirmware = true;
  services.fwupd.enable = true;

  environment.systemPackages = [
    (lib.hiPrio pkgs.uutils-coreutils-noprefix)
  ];

  security.sudo-rs.enable = true;

  # Required to set user shell
  programs.zsh.enable = true;

  virtualisation.podman.enable = true;

  system.stateVersion = lib.mkDefault "23.05";
}
