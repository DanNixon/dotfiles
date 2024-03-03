{...}: {
  home.shellAliases = {
    f = "nnn";
  };

  programs.nnn.enable = true;

  home.sessionVariables = {
    NNN_OPTS = "d";
  };
}
