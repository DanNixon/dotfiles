{
  inputs,
  config,
  pkgs,
  ...
}: {
  programs.neovim.plugins = with pkgs; [
    # Colour scheme
    (vimPlugins.base16-vim.overrideAttrs (
      old: let
        schemeFile = config.scheme inputs.base16-vim;
      in {patchPhase = ''cp ${schemeFile} colors/base16-scheme.vim'';}
    ))

    # Provides powerline style status line
    vimPlugins.vim-airline
    vimPlugins.vim-airline-themes

    # Provides easy line/block comment toggling
    vimPlugins.vim-commentary

    # Completion
    vimPlugins.nvim-cmp
    vimPlugins.vim-vsnip
    vimPlugins.cmp-vsnip
    vimPlugins.cmp-calc
    vimPlugins.cmp-buffer
    vimPlugins.cmp-nvim-lsp
    vimPlugins.cmp-path

    # Used to format and make editing CSV files trivial
    vimPlugins.csv

    # Fast jumping to markers in a file
    vimPlugins.easymotion

    # Applies formatting rules based on editorconfig files
    vimPlugins.editorconfig-vim

    # Fuzzy finding
    vimPlugins.fzf-lua

    # Enhanced spelling and grammar checking
    vimPlugins.vim-lexical

    # Language server client
    vimPlugins.nvim-lspconfig

    # Provides tree based file explorer
    vimPlugins.nerdtree

    # Restores cursor position on opening previously opened files
    vimPlugins.restore-view-vim

    # Format text into one line per sentence
    vimPlugins.vim-sentence-chopper

    # Provides ctags based navigation of current file
    vimPlugins.tagbar

    # Query and insert unicode characters
    vimPlugins.unicode-vim

    # Icons (e.g. file types) for other plugins
    vimPlugins.nvim-web-devicons

    # Syntax highlighting
    vimPlugins.vim-polyglot
    vimPlugins.vim-openscad
    vimPlugins.vim-nftables
  ];
}
