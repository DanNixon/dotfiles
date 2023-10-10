{inputs, ...}: {
  imports = [
    inputs.nix-index-database.hmModules.nix-index
  ];

  programs.nix-index-database.comma.enable = true;

  programs.nix-index = {
    enableZshIntegration = false;
    enableBashIntegration = false;
  };
}
