{pkgs, ...}: {
  programs.neovim = {
    enable = true;

    extraLuaConfig = builtins.readFile ./init.lua;

    extraPackages = with pkgs; [
      nodejs
    ];

    plugins = with pkgs.vimPlugins; [
      # Provides easy line/block comment toggling
      vim-commentary

      # Completion
      nvim-cmp
      vim-vsnip
      cmp-vsnip
      cmp-buffer
      cmp-nvim-lsp
      cmp-path
      copilot-cmp

      # Used to format and make editing CSV files trivial
      csv

      # Fuzzy finding
      fzf-lua

      # Status line
      lualine-nvim

      # Language server client
      nvim-lspconfig

      # Tree based file explorer
      neo-tree-nvim

      # Restores cursor position on opening previously opened files
      restore-view-vim

      # Format text into one line per sentence
      vim-sentence-chopper

      # Colour schemes
      tinted-nvim

      # Treesitter
      nvim-treesitter.withAllGrammars

      # Query and insert unicode characters
      unicode-vim

      # Github Copilot
      copilot-lua
      CopilotChat-nvim

      # Cargo.toml editing
      crates-nvim
    ];
  };
}
