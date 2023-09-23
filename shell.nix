{ pkgs ? (import ./nixpkgs.nix) {} }: {
  default = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      sops
      ssh-to-age
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
