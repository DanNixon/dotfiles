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
      ../../../modules/home-manager/terminal_environment/hsxkpasswd
      ../../../modules/home-manager/terminal_environment/ssh-config
      ../../../modules/home-manager/desktop_environment
      ../../../modules/home-manager/cad.nix
      ../../../modules/home-manager/development.nix
      ../../../modules/home-manager/media.nix
      ../../../modules/home-manager/office.nix

      ({pkgs, ...}: {
        home.packages = with pkgs; [
          lightburn
        ];

        services.flatpak.packages = [
          "org.chromium.Chromium"
          "com.microsoft.Edge"
        ];

        programs.bottom.settings.flags.battery = true;
      })
    ];
  }
