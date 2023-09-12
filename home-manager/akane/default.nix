{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ../common/terminal_environment
    ../common/media.nix
    ../common/development.nix
    ../common/desktop_environment
  ];

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

  services.mpd.enable = true;

  home.packages = with pkgs; [
    scrcpy
  ];
}
