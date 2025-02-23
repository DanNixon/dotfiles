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
      ../../../modules/home-manager/terminal_environment/ssh-config
      ../../../modules/home-manager/desktop_environment
      ../../../modules/home-manager/cad.nix
      ../../../modules/home-manager/development.nix
      ../../../modules/home-manager/media.nix
      ../../../modules/home-manager/office.nix

      ({pkgs, ...}: {
        home.packages = with pkgs; [
          lightburn
          nur.repos.DanNixon.metty
        ];

        services.flatpak.packages = [
          "org.chromium.Chromium"
          "com.microsoft.Edge"
        ];

        wayland.windowManager.sway = {
          config = {
            input."2:7:SynPS/2_Synaptics_TouchPad" = {
              events = "disabled";
            };

            output = {
              LVDS-1 = {
                enable = "";
              };
            };
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

        programs.bottom.settings.flags.battery = true;
      })
    ];
  }
