{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.sway = {
    enable = true;
    package = null;

    config = let
      brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
      de-screenshot = "${pkgs.de-screenshot}/bin/de-screenshot";
      ddcutil-modify-vcp = "${pkgs.ddcutil-modify-vcp}/bin/ddcutil-modify-vcp";
      media-control = "${pkgs.media-control}/bin/media-control";
      pactl = "${pkgs.pulseaudio}/bin/pactl";
    in {
      modifier = "Mod4"; # Super

      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
        d_px = "100";
      in {
        "${modifier}+g" = "exec ${pkgs.swaylock}/bin/swaylock";
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

        "${modifier}+e" = "mode \"sink volume\"";
        "${modifier}+r" = "mode resize";

        "${modifier}+space" = "exec alacritty";
        "${modifier}+p" = "exec ${de-screenshot}";

        "${modifier}+semicolon" = "exec alacritty --class sway-helper -e sway-helper combi";

        "XF86AudioRaiseVolume" = "exec --no-startup-id ${pactl} set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec --no-startup-id ${pactl} set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec --no-startup-id ${pactl} set-sink-mute @DEFAULT_SINK@ toggle";

        "XF86MonBrightnessUp" = "exec --no-startup-id ${brightnessctl} set '+5%'";
        "XF86MonBrightnessDown" = "exec --no-startup-id ${brightnessctl} set '5%-'";

        "XF86AudioPlay" = "exec --no-startup-id ${media-control} pause";
        "XF86AudioPause" = "exec --no-startup-id ${media-control} pause";
        "XF86AudioPrev" = "exec --no-startup-id ${media-control} prev";
        "XF86AudioNext" = "exec --no-startup-id ${media-control} next";
        "XF86AudioStop" = "exec --no-startup-id ${media-control} stop";
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
          "k" = "exec --no-startup-id ${pactl} set-sink-volume @DEFAULT_SINK@ +5%";
          "j" = "exec --no-startup-id ${pactl} set-sink-volume @DEFAULT_SINK@ -5%";
          "h" = "exec --no-startup-id ${pactl} set-sink-mute @DEFAULT_SINK@ toggle";

          "escape" = "mode default";
          "${modifier}+e" = "mode \"source volume\"";
        };

        "source volume" = {
          "k" = "exec --no-startup-id ${pactl} set-source-volume @DEFAULT_SOURCE@ +5%";
          "j" = "exec --no-startup-id ${pactl} set-source-volume @DEFAULT_SOURCE@ -5%";
          "h" = "exec --no-startup-id ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle";

          "escape" = "mode default";
          "${modifier}+e" = "mode \"laptop brightness\"";
        };

        "laptop brightness" = {
          "k" = "exec --no-startup-id ${brightnessctl} set '+5%'";
          "j" = "exec --no-startup-id ${brightnessctl} set '5%-'";

          "escape" = "mode default";
          "${modifier}+e" = "mode \"monitor brightness\"";
        };

        "monitor brightness" = {
          "k" = "exec --no-startup-id ${ddcutil-modify-vcp} 10 adjust +10";
          "j" = "exec --no-startup-id ${ddcutil-modify-vcp} 10 adjust -10";

          "a" = "exec --no-startup-id ${ddcutil-modify-vcp} 10 set 20";
          "s" = "exec --no-startup-id ${ddcutil-modify-vcp} 10 set 40";
          "d" = "exec --no-startup-id ${ddcutil-modify-vcp} 10 set 60";
          "f" = "exec --no-startup-id ${ddcutil-modify-vcp} 10 set 80";
          "g" = "exec --no-startup-id ${ddcutil-modify-vcp} 10 set 100";

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
      };

      gaps = {
        inner = 10;
        outer = -2;
      };

      floating.criteria = [
        {
          app_id = "sway-helper";
        }
        {
          instance = "qjackctl";
          title = "JACK Audio Connection Kit*";
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
      };

      colors = with config.scheme.withHashtag; {
        background = "${base07}";
        focused = rec {
          border = childBorder;
          background = "${base0D}";
          childBorder = "${base0D}";
          indicator = childBorder;
          text = "${base00}";
        };
        focusedInactive = rec {
          border = childBorder;
          background = "${base01}";
          childBorder = "${base01}";
          indicator = childBorder;
          text = "${base05}";
        };
        unfocused = rec {
          border = childBorder;
          background = "${base00}";
          childBorder = "${base01}";
          indicator = childBorder;
          text = "${base05}";
        };
        urgent = rec {
          border = childBorder;
          background = "${base08}";
          childBorder = "${base08}";
          indicator = childBorder;
          text = "${base00}";
        };
        placeholder = rec {
          border = childBorder;
          background = "${base00}";
          childBorder = "${base00}";
          indicator = childBorder;
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

  programs.swaylock = {
    enable = true;
    settings = {
      color = "${config.scheme.withHashtag.base00}";
      indicator-idle-visible = true;
    };
  };

  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 55;
        command = "${pkgs.swaylock}/bin/swaylock -fF";
      }
      {
        timeout = 60;
        command = "${pkgs.sway}/bin/swaymsg \"output * dpms off\"";
        resumeCommand = "${pkgs.sway}/bin/swaymsg \"output * dpms on\"";
      }
    ];
  };
}
