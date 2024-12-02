{config, ...}: {
  programs.alacritty = {
    enable = true;

    settings = {
      general = {
        live_config_reload = true;
      };

      env.TERM = "alacritty";

      window = {
        padding = {
          x = 2;
          y = 2;
        };
        decorations = "full";
        dynamic_title = true;
      };

      font = {
        size = 8.5;

        normal = {
          family = "DejaVuSansM Nerd Font Mono";
          style = "Regular";
        };
        bold = {
          family = "DejaVuSansM Nerd Font Mono";
          style = "Bold";
        };
        italic = {
          family = "DejaVuSansM Nerd Font Mono";
          style = "Italic";
        };
      };

      mouse = {
        hide_when_typing = false;
      };

      selection = {
        semantic_escape_chars = ",│`|:\"' ()[]{}<>";
      };

      cursor = {
        style = "Block";
        unfocused_hollow = true;
      };

      hints = {
        alphabet = "jfkdls;ahgurieowpq";

        enabled = [
          {
            regex = "(ipfs:|ipns:|magnet:|mailto:|gemini:|gopher:|https:|http:|news:|file:|git:|ssh:|ftp:)[^\\u0000-\\u001F\\u007F-\\u009F<>\"\\\\s{-}\\\\^⟨⟩`]+";
            hyperlinks = true;
            action = "Copy";
            post_processing = true;
            mouse.enabled = true;
            binding = {
              key = "Y";
              mods = "Control|Shift";
            };
          }
        ];
      };

      keyboard.bindings = [
        {
          key = "C";
          mods = "Control|Shift";
          action = "Copy";
        }
        {
          key = "V";
          mods = "Control|Shift";
          action = "Paste";
        }

        {
          key = "H";
          mods = "Control|Shift";
          action = "ResetFontSize";
        }
        {
          key = "K";
          mods = "Control|Shift";
          action = "IncreaseFontSize";
        }
        {
          key = "J";
          mods = "Control|Shift";
          action = "DecreaseFontSize";
        }
      ];

      colors = with config.scheme.withHashtag; let
        default = {
          black = base00;
          white = base07;
          inherit red green yellow blue cyan magenta;
        };
      in {
        primary = {
          background = base00;
          foreground = base07;
        };
        cursor = {
          text = base02;
          cursor = base07;
        };
        normal = default;
        bright = default;
        dim = default;
      };
    };
  };
}
