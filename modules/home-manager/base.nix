{
  lib,
  inputs,
  outputs,
  config,
  ...
}: {
  imports = [
    inputs.base16.homeManagerModule
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    inputs.sops-nix.homeManagerModules.sops
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

  sops.age.sshKeyPaths = ["${config.home.homeDirectory}/.ssh/sops-nix"];
}
