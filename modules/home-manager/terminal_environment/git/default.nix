{pkgs, ...}: {
  home.shellAliases = {
    g = "git";
    gs = "git s";
    lg = "lazygit";
  };

  home.packages = with pkgs; [
    gfold
    git
    lazygit
    jujutsu
  ];

  xdg.configFile = {
    "git/attributes".source = ./attributes;
    "git/config".source = ./config;
  };
}
