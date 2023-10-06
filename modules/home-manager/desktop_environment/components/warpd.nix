{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    warpd
  ];

  home.file.warpd-conf = {
    target = ".config/warpd/config";

    text = with config.scheme.withHashtag; ''
      hint_font: DejaVuSansM Nerd Font Mono Bold
      hint_bgcolor: ${blue}
      hint_fgcolor: ${base00}ff

      indicator: bottomright

      oneshot_buttons: Return - /

      speed: 150
      acceleration: 200
    '';
  };
}
