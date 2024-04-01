{pkgs, ...}: {
  imports = [
    ./config-lua.nix
    ./config-vim.nix
    ./plugins.nix
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      universal-ctags

      # Language servers
      marksman
      nixd
      yaml-language-server
    ];
  };
}
