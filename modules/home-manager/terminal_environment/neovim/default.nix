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
      nodejs

      # Language servers
      marksman
      nixd
      openscad-lsp
      yaml-language-server
    ];
  };
}
