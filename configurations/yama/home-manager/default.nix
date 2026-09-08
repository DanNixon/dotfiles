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
      ../../../modules/home-manager
      ../../../modules/home-manager/borgmatic.nix

      ({pkgs, ...}: {
        home.stateVersion = "26.05";

        programs.borgmatic.backups."main" = {
          location = {
            sourceDirectories = [
              "/home/dan/documents"
              "/home/dan/notebook"
              "/home/dan/.local/share/koishi-store"
              "/home/dan/.local/share/password-store"
              "/home/dan/phone"
            ];
            repositories = ["ssh://o2dl3om5@o2dl3om5.repo.borgbase.com/./repo"];
          };
          storage.encryptionPasscommand = "koishi get borg/yama.yaml passphrase";
        };

        home.packages = with pkgs; [
          gsender
          lightburn
        ];
      })
    ];
  }
