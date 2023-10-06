{
  description = "Dan's nix configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-anywhere = {
      url = "github:nix-community/nixos-anywhere";
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
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "aarch64-linux"
    ];
  in {
    overlays = import ./overlays {inherit inputs;};

    devShells = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./shell.nix {inherit inputs pkgs;}
    );

    nixosConfigurations = {
      akane = import ./configurations/akane/nixos {inherit inputs outputs;};
      kawashiro = import ./configurations/kawashiro/nixos {inherit inputs outputs;};
      maya = import ./configurations/maya/nixos {inherit inputs outputs;};
      yukari = import ./configurations/yukari/nixos {inherit inputs outputs;};
    };

    homeConfigurations = {
      akane = import ./configurations/akane/home-manager {inherit inputs outputs;};
      generic = import ./configurations/generic/home-manager {inherit inputs outputs;};
      kawashiro = import ./configurations/kawashiro/home-manager {inherit inputs outputs;};
      maya = import ./configurations/maya/home-manager {inherit inputs outputs;};
      yukari = import ./configurations/yukari/home-manager {inherit inputs outputs;};
    };
  };
}
