{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
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
    overlays = [
      outputs.overlays.additions
    ];

    config = {
      allowUnfree = true;
    };
  };

  hardware.enableRedistributableFirmware = true;

  environment.systemPackages = with pkgs; [
    # Core tools
    git
    neovim

    # Common inspection/diagnostic tools
    acpi
    bmon
    dogdns
    dua
    htop
    lm_sensors
    progress
    smartmontools
    tcpdump
    tree
  ];

  programs.iftop.enable = true;

  programs.zsh.enable = true;

  system.stateVersion = lib.mkDefault "23.05";
}
