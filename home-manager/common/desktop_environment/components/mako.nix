{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    libnotify
  ];

  services.mako = with config.scheme.withHashtag; {
    enable = true;

    font = "DejaVuSansM Nerd Font Mono";

    backgroundColor = "${base00}cc";
    textColor = "${base07}";
    borderColor = "${blue}";

    width = 400;
    height = 150;

    defaultTimeout = 5000;
  };
}
