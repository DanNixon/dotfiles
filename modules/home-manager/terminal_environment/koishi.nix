{pkgs, ...}: {
  home.shellAliases = {
    p = "koishi";
  };

  home.packages = with pkgs; [
    koishi
  ];
}
