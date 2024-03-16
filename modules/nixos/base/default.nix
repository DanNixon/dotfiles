{
  inputs,
  outputs,
  lib,
  config,
  ...
}: {
  imports = [
    ./locale.nix
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

      substituters = [
        "https://cache.nixos.org/"
        "https://nur-dannixon.cachix.org"
      ];
      trusted-public-keys = [
        "nur-dannixon.cachix.org-1:EHgimU2oe7pLXRF9Gji96CboWtyaFHC4pv5dMp/CRvw="
      ];
    };
  };

  nixpkgs = {
    config.allowUnfree = true;

    overlays = [
      outputs.overlays.additions
    ];
  };

  hardware.enableRedistributableFirmware = true;

  programs.iftop.enable = true;

  # Required to set user shell
  programs.zsh.enable = true;

  system.stateVersion = lib.mkDefault "23.05";
}
