{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ../common/terminal_environment
    ../common/media.nix
    ../common/development.nix
    ../common/desktop_environment
  ];

  wayland.windowManager.sway.config.output = {
    eDP-1 = {
      enable = "";
      bg = "#006070 solid_color";
    };
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

  home.packages = with pkgs; [
    lightburn
  ];
}
