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
      ../../../modules/home-manager/terminal_environment
      ../../../modules/home-manager/borgmatic.nix
      ../../../modules/home-manager/email

      ({pkgs, ...}: {
        programs.borgmatic.backups."main" = {
          location = {
            sourceDirectories = [
              "/home/dan/docs"
              "/home/dan/git"
              "/home/dan/phone"
              "/home/dan/tombs"
            ];
            repositories = ["ssh://sfxwxlb3@sfxwxlb3.repo.borgbase.com/./repo"];
          };
          storage.encryptionPasscommand = "pass borg/yukari/passphrase";
        };

        home.packages = with pkgs; [
          inputs.satori.packages.${system}.satorictl
        ];
      })
    ];
  }
