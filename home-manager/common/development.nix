{ pkgs, ... }: {
  home.packages = with pkgs; [
    buildah

    kubectl
    kubectx
    kubernetes-helm

    terraform
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
