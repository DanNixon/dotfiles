{
  description = "Dan's nix configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko/v1.11.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/v0.2.0";

    base16.url = "github:SenchoPens/base16.nix";

    tt-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };

    tinted-vim = {
      url = "github:tinted-theming/tinted-vim/24d384a064d09a20eca7e78a0bfe1fb302c0eb99";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;

    systems = [
      "x86_64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
      "aarch64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    devShells = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        default = pkgs.mkShell {
          packages = with pkgs; [
            nixos-anywhere

            # Formatting tools
            alejandra
            treefmt
            mdl

            # Secret management
            ssh-to-age
            sops
          ];
        };

        bootstrap = pkgs.mkShell {
          NIX_CONFIG = "experimental-features = nix-command flakes";

          packages = with pkgs; [
            git
            home-manager
          ];
        };
      }
    );

    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations = {
      akane = import ./configurations/akane/nixos {inherit inputs outputs;};
      hina = import ./configurations/hina/nixos {inherit inputs outputs;};
      maya = import ./configurations/maya/nixos {inherit inputs outputs;};
    };

    homeConfigurations = {
      "dan@akane" = import ./configurations/akane/home-manager {inherit inputs outputs;};
      generic = import ./configurations/generic/home-manager {inherit inputs outputs;};
      "dan@hina" = import ./configurations/hina/home-manager {inherit inputs outputs;};
      "dan@maya" = import ./configurations/maya/home-manager {inherit inputs outputs;};
    };
  };
}
