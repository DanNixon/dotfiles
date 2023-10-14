{pkgs, ...}: {
  home.packages = with pkgs; [
    distrobox

    kubectl
    kubectx

    shellcheck
  ];

  programs.gh = {
    enable = true;
    enableGitCredentialHelper = false;
    settings = {
      git_protocol = "ssh";
    };
  };

  programs.k9s = {
    enable = true;
  };
}
