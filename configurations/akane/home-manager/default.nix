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
      ../../../modules/home-manager/desktop_environment
      ../../../modules/home-manager/borgmatic.nix
      ../../../modules/home-manager/cad.nix
      ../../../modules/home-manager/development.nix
      ../../../modules/home-manager/media.nix
      ../../../modules/home-manager/office.nix

      ({pkgs, ...}: {
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

        services.mpd.enable = true;

        programs.borgmatic.backups."main" = {
          location = {
            sourceDirectories = [
              "/home/dan/docs"
              "/home/dan/phone"
              "/home/dan/tombs"
            ];
            repositories = ["ssh://r4zp295h@r4zp295h.repo.borgbase.com/./repo"];
          };
          storage.encryptionPasscommand = "pass borg/akane/passphrase";
        };

        wayland.windowManager.sway.config = {
          input."2:7:SynPS/2_Synaptics_TouchPad" = {
            events = "disabled";
          };

          output = {
            LVDS-1 = {
              enable = "";
              bg = "~/.local/share/wallpaper.png fill";
            };
          };
        };

        home.file.wallpaper = {
          source = ./wallpaper.png;
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
