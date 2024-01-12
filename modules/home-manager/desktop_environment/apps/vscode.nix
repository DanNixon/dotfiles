{pkgs, ...}: {
  programs.vscode = {
    enable = true;

    package = pkgs.vscodium;

    extensions = with pkgs.vscode-extensions; [
      github.copilot
      vscodevim.vim
    ];
  };
}