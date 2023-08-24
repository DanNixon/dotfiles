{ inputs, outputs, config, pkgs, ... }: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };

    overlays = [
      outputs.overlays.additions
    ];
  };

  home = {
    username = "dan";
    homeDirectory = "/home/dan";
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
}
