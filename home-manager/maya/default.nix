{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ../common/terminal_environment
    ../common/borgmatic.nix
    ../common/media.nix
    ../common/development.nix
    ../common/desktop_environment
  ];

  programs.borgmatic.backups."main" = {
    location = {
      sourceDirectories = [
        "/home/dan/docs"
        "/home/dan/phone"
        "/home/dan/tombs"
      ];
      repositories = [ "n0f5xqc1@n0f5xqc1.repo.borgbase.com:repo" ];
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
}
