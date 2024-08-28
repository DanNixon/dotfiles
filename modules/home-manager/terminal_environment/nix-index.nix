{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nix-index-database.hmModules.nix-index
  ];

  programs.nix-index = {
    enableZshIntegration = false;
    enableBashIntegration = false;
  };

  programs.nix-index-database.comma.enable = true;
  home.sessionVariables.COMMA_PICKER = "${pkgs.fzf}/bin/fzf";
}
