{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nix-index-database.homeModules.nix-index
  ];

  programs.nix-index = {
    enableFishIntegration = false;
    enableBashIntegration = false;
  };

  programs.nix-index-database.comma.enable = true;
  home.sessionVariables.COMMA_PICKER = "${pkgs.fzf}/bin/fzf";
}
