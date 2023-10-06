{
  inputs,
  outputs,
}:
inputs.home-manager.lib.homeManagerConfiguration {
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  extraSpecialArgs = {inherit inputs outputs;};

  modules = [
    ../../../modules/home-manager/terminal_environment
    ../../../modules/home-manager/media.nix
    ../../../modules/home-manager/development.nix
    ../../../modules/home-manager/desktop_environment

    ({pkgs, ...}: {
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
    })
  ];
}
