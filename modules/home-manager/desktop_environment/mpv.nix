{...}: {
  programs.mpv = {
    enable = true;

    bindings = {
      "h" = "seek -5";
      "j" = "seek 60";
      "k" = "seek -60";
      "l" = "seek 5";

      # Make shift-j cycle subtitles normally (since j is used for Vi style transport)
      "J" = "cycle sub";
    };
  };
}
