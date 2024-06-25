{config, ...}: {
  home.file.tofi-config = {
    target = ".config/tofi/config";

    text = with config.scheme.withHashtag; ''
      fuzzy-match = true
      require-match = false

      width = 40%
      height = 50%

      border-width = 1
      outline-width = 0

      padding-left = 2
      padding-top = 2

      result-spacing = 0

      font = DejaVuSansM Nerd Font
      font-size = 10

      text-cursor = true

      background-color = ${base00}cc
      border-color = ${blue}
      prompt-color = ${yellow}
      text-color = ${base07}
      selection-color = ${red}
    '';
  };
}
