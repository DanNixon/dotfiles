{pkgs, ...}: {
  home.shellAliases = {
    k = "kubectl";
    kk = "k9s";
  };

  home.packages = with pkgs; [
    distrobox

    kubectl
    kubectx

    rustup

    shellcheck

    # Line of code reporting tool
    tokei
  ];

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = false;
    settings.git_protocol = "ssh";
  };

  programs.k9s.enable = true;

  services.flatpak.packages = [
    "io.kinvolk.Headlamp"
    "net.werwolv.ImHex"
  ];
}
