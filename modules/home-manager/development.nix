{pkgs, ...}: {
  home.packages = with pkgs; [
    distrobox

    kubectl
    kubectx

    shellcheck

    # Line of code reporting tool
    tokei
  ];

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = false;
    settings.git_protocol = "ssh";
  };

  programs.k9s = {
    enable = true;
  };
}
