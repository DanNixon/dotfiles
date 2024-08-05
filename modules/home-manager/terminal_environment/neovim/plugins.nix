{
  inputs,
  config,
  pkgs,
  ...
}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    # Colour scheme
    (base16-vim.overrideAttrs (
      old: let
        schemeFile = config.scheme inputs.base16-vim;
      in {patchPhase = ''cp ${schemeFile} colors/base16-scheme.vim'';}
    ))

    # Provides easy line/block comment toggling
    vim-commentary

    # Completion
    nvim-cmp
    vim-vsnip
    cmp-vsnip
    cmp-buffer
    cmp-nvim-lsp
    cmp-path

    # Used to format and make editing CSV files trivial
    csv

    # Fast jumping to markers in a file
    easymotion

    # Fuzzy finding
    fzf-lua

    # Status line
    lualine-nvim

    # Enhanced spelling and grammar checking
    vim-lexical

    # Language server client
    nvim-lspconfig

    # Tree based file explorer
    neo-tree-nvim

    # Restores cursor position on opening previously opened files
    restore-view-vim

    # Format text into one line per sentence
    vim-sentence-chopper

    # Treesitter
    nvim-treesitter.withAllGrammars

    # Query and insert unicode characters
    unicode-vim
  ];
}
