{
  description = "Dan's nix configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";

    disko = {
      url = "github:nix-community/disko/v1.6.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
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

    base16-vim = {
      url = "github:tinted-theming/base16-vim";
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
            rustfmt
            treefmt
            mdl

            # Secret management
            ssh-to-age
            sops

            # Rust toolchain
            cargo
            rustc
            clippy
            rust-analyzer
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
      kawashiro = import ./configurations/kawashiro/nixos {inherit inputs outputs;};
      maya = import ./configurations/maya/nixos {inherit inputs outputs;};
    };

    homeConfigurations = {
      "dan@akane" = import ./configurations/akane/home-manager {inherit inputs outputs;};
      generic = import ./configurations/generic/home-manager {inherit inputs outputs;};
      "dan@hina" = import ./configurations/hina/home-manager {inherit inputs outputs;};
      "dan@kawashiro" = import ./configurations/kawashiro/home-manager {inherit inputs outputs;};
      "dan@maya" = import ./configurations/maya/home-manager {inherit inputs outputs;};
      minimal = import ./configurations/minimal/home-manager {inherit inputs outputs;};
    };
  };
}
