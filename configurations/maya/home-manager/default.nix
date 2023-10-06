{
  inputs,
  outputs,
}:
inputs.home-manager.lib.homeManagerConfiguration {
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  extraSpecialArgs = {inherit inputs outputs;};

  modules = [
    ../../../modules/home-manager/terminal_environment
    ../../../modules/home-manager/borgmatic.nix
    ../../../modules/home-manager/media.nix
    ../../../modules/home-manager/development.nix
    ../../../modules/home-manager/email
    ../../../modules/home-manager/desktop_environment

    ({pkgs, ...}: {
      programs.borgmatic.backups."main" = {
        location = {
          sourceDirectories = [
            "/home/dan/docs"
            "/home/dan/phone"
            "/home/dan/tombs"
          ];
          repositories = ["n0f5xqc1@n0f5xqc1.repo.borgbase.com:repo"];
        };
        storage.encryptionPasscommand = "pass borg/maya/passphrase";
      };

      wayland.windowManager.sway.config.output = {
        DP-1 = {
          enable = "";
          bg = "~/.local/share/wallpaper.png fill";
          scale = "1.5";
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
          block = "time";
          interval = 1;
          format = " $timestamp.datetime(f:'%Y-%m-%d %H:%M:%S') ";
        }
      ];

      services.mpd.enable = true;

      home.packages = with pkgs; [
        inputs.satori.packages.${system}.satorictl
      ];
    })
  ];
}
