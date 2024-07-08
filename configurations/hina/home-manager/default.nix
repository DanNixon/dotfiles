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
      ../../../modules/home-manager/terminal_environment/hsxkpasswd
      ../../../modules/home-manager/terminal_environment/rclone
      ../../../modules/home-manager/terminal_environment/ssh-config
      ../../../modules/home-manager/desktop_environment
      ../../../modules/home-manager/borgmatic.nix
      ../../../modules/home-manager/cad.nix
      ../../../modules/home-manager/development.nix
      ../../../modules/home-manager/media.nix
      ../../../modules/home-manager/office.nix

      ({
        config,
        pkgs,
        ...
      }: rec {
        home.packages = with pkgs; [
          lightburn
          scrcpy
          nur.repos.DanNixon.metty
          nur.repos.DanNixon.satorictl-unstable
        ];

        services.flatpak.packages = [
          "org.chromium.Chromium"
          "com.microsoft.Edge"

          "com.adobe.Flash-Player-Projector"
        ];

        xdg.userDirs.music = "${config.home.homeDirectory}/music";
        services.mpd.enable = true;

        programs.borgmatic.backups."main" = {
          location = {
            sourceDirectories = [
              "/home/dan/documents"
              "/home/dan/notebook"
              "/home/dan/.local/share/password-store"
              "/home/dan/phone"
            ];
            repositories = ["ssh://g5ows5p1@g5ows5p1.repo.borgbase.com/./repo"];
          };
          storage.encryptionPasscommand = "pass borg/hina/passphrase";
        };

        wayland.windowManager.sway = {
          checkConfig = false; # Does not work with background image paths

          config = {
            input."2:10:TPPS/2_IBM_TrackPoint" = {
              pointer_accel = "-0.4";
            };

            output = {
              eDP-1 = {
                enable = "";
                bg = "~/${home.file.wallpaper.target} fill";
              };
            };
          };
        };

        home.file.wallpaper = {
          source = ../../../wallpapers/aya.png;
          target = ".local/share/wallpaper.png";
        };

        programs.i3status-rust.bars.main.blocks = [
          {
            block = "sound";
            driver = "pulseaudio";
            device_kind = "sink";
          }
          {
            block = "sound";
            driver = "pulseaudio";
            device_kind = "source";
          }
          {
            block = "battery";
          }
          {
            block = "time";
            interval = 1;
            format = " $timestamp.datetime(f:'%Y-%m-%d %H:%M:%S') ";
          }
        ];

        programs.bottom.settings.flags.battery = true;
      })
    ];
  }
