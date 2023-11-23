{
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./config.nix
    ./plugins.nix
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    extraPackages = [
      pkgs.universal-ctags
      pkgs-unstable.nixd
    ];
  };
}
