{
  inputs,
  pkgs ? (import ./nixpkgs.nix) {},
}: {
  default = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      sops
      inputs.nixos-anywhere.packages.${system}.nixos-anywhere
    ];
  };

  bootstrap = pkgs.mkShell {
    NIX_CONFIG = "experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [
      git
      home-manager
      neovim
      nix
      sops
      ssh-to-age
    ];
  };
}
