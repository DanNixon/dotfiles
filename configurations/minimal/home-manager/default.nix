{
  inputs,
  outputs,
}: let
  pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
in
  inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    extraSpecialArgs = {inherit inputs outputs pkgs-unstable;};

    modules = [
      ../../../modules/home-manager/base.nix
      ../../../modules/home-manager/terminal_environment/git.nix
      ../../../modules/home-manager/terminal_environment/neovim
      ../../../modules/home-manager/terminal_environment/shell.nix
      ../../../modules/home-manager/terminal_environment/zellij.nix
      ../../../modules/home-manager/terminal_environment/zsh.nix

      ({pkgs, ...}: {
        home.packages = with pkgs; [
          # System tools
          bottom
          dmidecode
          lm_sensors
          fastfetch
          pciutils
          progress
          usbutils

          # Disk/filesystem tools
          dua
          smartmontools
          tree

          # Networking tools
          bmon
        ];

        # home = {
        #   username = "dan";
        #   homeDirectory = "/home/dan";
        # };
      })
    ];
  }
