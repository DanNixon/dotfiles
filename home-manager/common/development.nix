{ pkgs, ... }: {
  home.packages = with pkgs; [
    kubectl
    kubectx
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
