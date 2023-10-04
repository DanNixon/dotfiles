{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    ddcutil-modify-vcp
    media-control

    # Provide pactl (used for some other custom tools)
    pulseaudio
  ];

  wayland.windowManager.sway = {
    enable = true;
    package = null;

    config = {
      modifier = "Mod4"; # Super

      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
        d_px = "100";
      in {
        "${modifier}+g" = "exec swaylock --color 002030";
        "${modifier}+shift+g" = "exit";

        "${modifier}+shift+q" = "kill";

        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";

        "${modifier}+shift+h" = "move left ${d_px}";
        "${modifier}+shift+j" = "move down ${d_px}";
        "${modifier}+shift+k" = "move up ${d_px}";
        "${modifier}+shift+l" = "move right ${d_px}";

        "${modifier}+u" = "split vertical";
        "${modifier}+i" = "split horizontal";
        "${modifier}+o" = "layout toggle splitv splith stacking tabbed";

        "${modifier}+comma" = "fullscreen";
        "${modifier}+period" = "floating toggle";

        "${modifier}+a" = "workspace number 0";
        "${modifier}+s" = "workspace number 1";
        "${modifier}+d" = "workspace number 2";
        "${modifier}+f" = "workspace number 3";
        "${modifier}+x" = "workspace number 4";
        "${modifier}+c" = "workspace number 5";
        "${modifier}+v" = "workspace number 6";

        "${modifier}+shift+a" = "move workspace number 0";
        "${modifier}+shift+s" = "move workspace number 1";
        "${modifier}+shift+d" = "move workspace number 2";
        "${modifier}+shift+f" = "move workspace number 3";
        "${modifier}+shift+x" = "move workspace number 4";
        "${modifier}+shift+c" = "move workspace number 5";
        "${modifier}+shift+v" = "move workspace number 6";

        "${modifier}+e" = "mode \"sink volume\"";
        "${modifier}+r" = "mode resize";

        "${modifier}+m" = "exec warpd --hint";
        "${modifier}+shift+m" = "exec warpd --normal";

        "${modifier}+space" = "exec alacritty";
        "${modifier}+semicolon" = "exec tofi-run | xargs swaymsg exec --";

        "${modifier}+p" = "exec de-screenshot";

        "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";

        "XF86MonBrightnessUp" = "exec --no-startup-id light -A 5";
        "XF86MonBrightnessDown" = "exec --no-startup-id light -U 5";

        "XF86AudioPlay" = "exec --no-startup-id media-control pause";
        "XF86AudioPause" = "exec --no-startup-id media-control pause";
        "XF86AudioPrev" = "exec --no-startup-id media-control prev";
        "XF86AudioNext" = "exec --no-startup-id media-control next";
        "XF86AudioStop" = "exec --no-startup-id media-control stop";
      };

      modes = let
        modifier = config.wayland.windowManager.sway.config.modifier;
        d_px = "100";
        d_ppt = "10";
      in {
        "resize" = {
          "h" = "resize shrink left ${d_px} px or ${d_ppt} ppt";
          "shift+h" = "resize grow left ${d_px} px or ${d_ppt} ppt";

          "j" = "resize shrink down ${d_px} px or ${d_ppt} ppt";
          "shift+j" = "resize grow down ${d_px} px or ${d_ppt} ppt";

          "k" = "resize shrink up ${d_px} px or ${d_ppt} ppt";
          "shift+k" = "resize grow up ${d_px} px or ${d_ppt} ppt";

          "l" = "resize shrink right ${d_px} px or ${d_ppt} ppt";
          "shift+l" = "resize grow right ${d_px} px or ${d_ppt} ppt";

          "escape" = "mode default";
        };

        "sink volume" = {
          "k" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "j" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%";
          "h" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";

          "escape" = "mode default";
          "${modifier}+e" = "mode \"source volume\"";
        };

        "source volume" = {
          "k" = "exec --no-startup-id pactl set-source-volume @DEFAULT_SOURCE@ +5%";
          "j" = "exec --no-startup-id pactl set-source-volume @DEFAULT_SOURCE@ -5%";
          "h" = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle";

          "escape" = "mode default";
          "${modifier}+e" = "mode \"laptop brightness\"";
        };

        "laptop brightness" = {
          "k" = "exec --no-startup-id light -A 5";
          "j" = "exec --no-startup-id light -U 5";

          "escape" = "mode default";
          "${modifier}+e" = "mode \"monitor brightness\"";
        };

        "monitor brightness" = {
          "k" = "exec --no-startup-id ddcutil-modify-vcp 10 adjust +10";
          "j" = "exec --no-startup-id ddcutil-modify-vcp 10 adjust -10";

          "a" = "exec --no-startup-id ddcutil-modify-vcp 10 set 20";
          "s" = "exec --no-startup-id ddcutil-modify-vcp 10 set 40";
          "d" = "exec --no-startup-id ddcutil-modify-vcp 10 set 60";
          "f" = "exec --no-startup-id ddcutil-modify-vcp 10 set 80";
          "g" = "exec --no-startup-id ddcutil-modify-vcp 10 set 100";

          "escape" = "mode default";
          "${modifier}+e" = "mode \"sink volume\"";
        };
      };

      bars = [
        {
          position = "bottom";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs config-main.toml";
          fonts = {
            names = ["DejaVuSansM Nerd Font Mono"];
            size = 14.0;
          };
          colors = with config.scheme.withHashtag; {
            separator = "${base07}";
            background = "${base01}88";
            statusline = "${base07}";
            focusedWorkspace = {
              border = "${base07}";
              background = "${base03}88";
              text = "${base07}";
            };
            activeWorkspace = {
              border = "${base07}";
              background = "${base01}88";
              text = "${base07}";
            };
            inactiveWorkspace = {
              border = "${base01}88";
              background = "${base01}88";
              text = "${base06}";
            };
            urgentWorkspace = {
              border = "${base08}";
              background = "${base08}88";
              text = "${base07}";
            };
          };
        }
      ];

      fonts = {
        names = ["DejaVuSansM Nerd Font Mono"];
        size = 10.0;
      };

      focus = {
        followMouse = false;
        wrapping = "no";
      };

      window = {
        titlebar = false;
        commands = [
          {
            criteria = {
              app_id = "Alacritty";
            };
            command = "opacity 0.92";
          }
        ];
      };

      gaps = {
        inner = 10;
        outer = -2;
      };

      floating.criteria = [
        {
          app_id = "FloatingAlacritty";
        }
        {
          instance = "qjackctl";
          title = "JACK Audio Connection Kit*";
        }
        {
          app_id = "firefox";
          title = "Firefox — Sharing Indicator";
        }
      ];

      input = {
        "type:keyboard" = {
          xkb_layout = "gb";
          xkb_options = "altwin:swap_lalt_lwin,caps:none";
        };
        "4617:10533:DanNixon_Aya" = {
          xkb_layout = "gb";
          xkb_options = "none";
        };
        "49835:14649:DPB_Ferris_sweep" = {
          xkb_layout = "gb";
          xkb_options = "none";
        };
        "1149:4130:Kensington_USB_Orbit" = {
          accel_profile = "adaptive";
          # pointer_accel = 1;
        };
      };

      colors = with config.scheme.withHashtag; {
        background = "${base07}";
        focused = {
          background = "${base0D}";
          border = "${base05}";
          childBorder = "${base0D}";
          indicator = "${base0D}";
          text = "${base00}";
        };
        focusedInactive = {
          background = "${base01}";
          border = "${base01}";
          childBorder = "${base01}";
          indicator = "${base03}";
          text = "${base05}";
        };
        unfocused = {
          background = "${base00}";
          border = "${base01}";
          childBorder = "${base01}";
          indicator = "${base01}";
          text = "${base05}";
        };
        urgent = {
          background = "${base08}";
          border = "${base08}";
          childBorder = "${base08}";
          indicator = "${base08}";
          text = "${base00}";
        };
        placeholder = {
          background = "${base00}";
          border = "${base00}";
          childBorder = "${base00}";
          indicator = "${base00}";
          text = "${base05}";
        };
      };
    };
  };

  programs.i3status-rust = {
    enable = true;
    bars.main = {
      theme = "native";
      icons = "awesome4";
    };
  };
}
