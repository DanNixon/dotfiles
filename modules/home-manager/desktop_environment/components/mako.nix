{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    libnotify
  ];

  services.mako = with config.scheme.withHashtag; {
    enable = true;

    settings = {
      font = "DejaVuSansM Nerd Font Mono";

      background-color = "${base00}cc";
      text-color = "${base07}";
      border-color = "${blue}";

      width = 400;
      height = 150;

      default-timeout = 5000;
    };
  };
}
