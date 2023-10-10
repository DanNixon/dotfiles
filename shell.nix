{
  inputs ? {},
  pkgs ? (import ./nixpkgs.nix) {},
}: let
  common = with pkgs; [
    sops
  ];
in {
  default = pkgs.mkShell {
    nativeBuildInputs =
      (with pkgs; [
        inputs.nixos-anywhere.packages.${system}.nixos-anywhere

        alejandra
        treefmt
      ])
      ++ common;
  };

  bootstrap = pkgs.mkShell {
    NIX_CONFIG = "experimental-features = nix-command flakes";
    nativeBuildInputs =
      (with pkgs; [
        git
        home-manager
        neovim
        nix
        sops
        ssh-to-age
      ])
      ++ common;
  };
}
