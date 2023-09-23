# Shell for bootstrapping flake-enabled nix and other tooling
{ pkgs ? (import ./nixpkgs.nix) { } }: {
  default = pkgs.mkShell {
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
