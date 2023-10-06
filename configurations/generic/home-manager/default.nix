{
  inputs,
  outputs,
}:
inputs.home-manager.lib.homeManagerConfiguration {
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  extraSpecialArgs = {inherit inputs outputs;};

  modules = [
    ../../../modules/home-manager/terminal_environment
    ../../../modules/home-manager/development.nix

    {
      # home = {
      #   username = "dan";
      #   homeDirectory = "/home/dan";
      # };
    }
  ];
}
