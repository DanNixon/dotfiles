{
  lib,
  inputs,
  outputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.base16.homeManagerModule
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };

    overlays = [
      outputs.overlays.additions
    ];
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  home = {
    username = lib.mkDefault "dan";
    homeDirectory = lib.mkDefault "/home/dan";

    stateVersion = lib.mkDefault "23.05";
  };
}
