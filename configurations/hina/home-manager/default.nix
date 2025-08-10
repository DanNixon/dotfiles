{
  inputs,
  outputs,
}: let
  pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
in
  inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    extraSpecialArgs = {inherit inputs outputs pkgs-unstable;};

    modules = [
      ../../../modules/home-manager/terminal_environment
      ../../../modules/home-manager/desktop_environment
      ../../../modules/home-manager/development.nix
      ../../../modules/home-manager/media.nix

      ({pkgs, ...}: {
        programs.bottom.settings.flags.battery = true;

        services.flatpak.packages = [
          "com.vesc_project.VescTool"
        ];
      })
    ];
  }
