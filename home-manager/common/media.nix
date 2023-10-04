{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # Tools to aid in creating digital copies/backups of physical media
    cdparanoia # Backing up audio CDs
    cdrdao # Backing up PS1 game CDs
    dvdbackup # Backing up DVDs
    xsane # Scanning

    # Tools for working with media files
    exiftool
    ffmpeg

    mpc-cli
  ];

  programs.feh.enable = true;

  programs.mpv = {
    enable = true;

    scripts = with pkgs.mpvScripts; [
      sponsorblock
      thumbfast
      vr-reversal
      youtube-quality
    ];

    config = {
      input-ipc-server = "/tmp/mpv-socket";
    };

    bindings = {
      "l" = "seek 5";
      "h" = "seek -5";
      "k" = "seek 60";
      "j" = "seek -60";

      # Make shift-j cycle subtitles normally (since j is used for Vi style transport)
      "J" = "cycle sub";
    };
  };

  programs.ncmpcpp = {
    enable = true;

    settings = {
      external_editor = "nvim";
      playlist_disable_highlight_delay = 0;
      lyrics_directory = "~/music/lyrics";
    };

    bindings = [
      {
        key = "mouse";
        command = "dummy";
      }
      {
        key = "up";
        command = "dummy";
      }
      {
        key = "down";
        command = "dummy";
      }
      {
        key = "left";
        command = "dummy";
      }
      {
        key = "right";
        command = "dummy";
      }
      {
        key = "shift-up";
        command = "dummy";
      }
      {
        key = "j";
        command = "scroll_down";
      }
      {
        key = "k";
        command = "scroll_up";
      }
      {
        key = "h";
        command = "previous_column";
      }
      {
        key = "h";
        command = "master_screen";
      }
      {
        key = "l";
        command = "next_column";
      }
      {
        key = "l";
        command = "slave_screen";
      }
      {
        key = "=";
        command = "volume_up";
      }
      {
        key = "-";
        command = "volume_down";
      }
      {
        key = "L";
        command = "show_lyrics";
      }
    ];
  };

  programs.yt-dlp.enable = true;

  services.mpd = {
    musicDirectory = "${config.home.homeDirectory}/music";

    extraConfig = ''
      audio_output {
        type "pulse"
        name "local"
      }

      audio_output {
        type "fifo"
        name "visualisation"
        path "/tmp/mpd.fifo"
        format "44100:16:2"
        visualizer_in_stereo "True"
      }

      audio_output {
        type "fifo"
        name "snapcast"
        path "/tmp/snapfifo"
        format "48000:16:2"
      }
    '';
  };
}
