{pkgs, ...}: {
  imports = [
    ./config.nix
    ./plugins.nix
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      universal-ctags
      nixd
    ];
  };
}
