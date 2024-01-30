{
  description = "Dan's nix configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-anywhere = {
      url = "github:nix-community/nixos-anywhere/1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.disko.follows = "disko";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/v0.2.0";

    base16.url = "github:SenchoPens/base16.nix";

    base16-schemes = {
      url = "github:base16-project/base16-schemes";
      flake = false;
    };

    base16-vim = {
      url = "github:base16-project/base16-vim";
      flake = false;
    };

    satori = {
      url = "github:dannixon/satori";
      inputs.nixpkgs.follows = "nixpkgs";
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
        nixos-anywhere = inputs.nixos-anywhere.packages.${system}.nixos-anywhere;
      in {
        default = pkgs.mkShell {
          packages = with pkgs; [
            nixos-anywhere

            alejandra
            treefmt
            mdl

            sops
          ];
        };

        bootstrap = pkgs.mkShell {
          NIX_CONFIG = "experimental-features = nix-command flakes";

          packages = with pkgs; [
            git
            home-manager
            neovim
            nix
            ssh-to-age
            sops
          ];
        };
      }
    );

    overlays = import ./overlays {inherit inputs;};

    nixosModules = {
      dan = import ./modules/nixos/dan;
    };

    nixosConfigurations = {
      akane = import ./configurations/akane/nixos {inherit inputs outputs;};
      kawashiro = import ./configurations/kawashiro/nixos {inherit inputs outputs;};
      maya = import ./configurations/maya/nixos {inherit inputs outputs;};
      yukari = import ./configurations/yukari/nixos {inherit inputs outputs;};
      yuyuko = import ./configurations/yuyuko/nixos {inherit inputs outputs;};
    };

    homeConfigurations = {
      "dan@akane" = import ./configurations/akane/home-manager {inherit inputs outputs;};
      generic = import ./configurations/generic/home-manager {inherit inputs outputs;};
      "dan@kawashiro" = import ./configurations/kawashiro/home-manager {inherit inputs outputs;};
      "dan@maya" = import ./configurations/maya/home-manager {inherit inputs outputs;};
      minimal = import ./configurations/minimal/home-manager {inherit inputs outputs;};
      "dan@yukari" = import ./configurations/yukari/home-manager {inherit inputs outputs;};
      "dan@yuyuko" = import ./configurations/yuyuko/home-manager {inherit inputs outputs;};
    };
  };
}
