{pkgs, ...}: {
  home.shellAliases = {
    k = "kubectl";
    kk = "k9s";
  };

  home.packages = with pkgs; [
    distrobox

    k9s
    kubectl

    shellcheck

    # Line of code reporting tool
    tokei
  ];

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = false;
    settings.git_protocol = "ssh";
  };
}
