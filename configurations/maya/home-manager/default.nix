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

      ({...}: {
        home.stateVersion = "26.05";

        programs.borgmatic.backups."main" = {
          location = {
            sourceDirectories = [
              "/home/dan/documents"
              "/home/dan/notebook"
              "/home/dan/.local/share/koishi-store"
              "/home/dan/phone"
            ];
            repositories = ["ssh://cs85w49w@cs85w49w.repo.borgbase.com/./repo"];
          };
          storage.encryptionPasscommand = "koishi get borg/maya.yaml passphrase";
        };
      })
    ];
  }
