{...}: {
  programs.xplr = {
    enable = true;

    extraConfig = ''
      xplr.config.general.initial_layout = "no_help"
    '';
  };
}
