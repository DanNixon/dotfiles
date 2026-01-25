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
        programs.borgmatic.backups."main" = {
          location = {
            sourceDirectories = [
              "/home/dan/documents"
              "/home/dan/notebook"
              "/home/dan/notebook-old"
              "/home/dan/.local/share/koishi-store"
              "/home/dan/.local/share/password-store"
              "/home/dan/phone"
            ];
            repositories = ["ssh://i3caziwg@i3caziwg.repo.borgbase.com/./repo"];
          };
          storage.encryptionPasscommand = "koishi get borg/hina.yaml passphrase";
        };
      })
    ];
  }
