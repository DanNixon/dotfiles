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

      ({config, ...}: {
        xdg.userDirs.music = "${config.home.homeDirectory}/music";
        services.mpd.enable = true;

        programs.borgmatic.backups."main" = {
          location = {
            sourceDirectories = [
              "/home/dan/docs"
              "/home/dan/notebook"
              "/home/dan/.local/share/koishi-store"
              "/home/dan/.local/share/password-store"
              "/home/dan/phone"
            ];
            repositories = ["ssh://n0f5xqc1@n0f5xqc1.repo.borgbase.com/./repo"];
          };
          storage.encryptionPasscommand = "koishi get borg/maya.yaml passphrase";
        };
      })
    ];
  }
