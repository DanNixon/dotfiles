{
  inputs,
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  programs.neovim.plugins = [
    # Colour scheme
    (pkgs.vimPlugins.base16-vim.overrideAttrs (
      old: let
        schemeFile = config.scheme inputs.base16-vim;
      in {patchPhase = ''cp ${schemeFile} colors/base16-scheme.vim'';}
    ))

    # GitHub copilot integration
    pkgs.vimPlugins.copilot-vim

    # Used to format and make editing CSV files trivial
    pkgs.vimPlugins.csv

    # Fast jumping to markers in a file
    pkgs.vimPlugins.easymotion

    # Applies formatting rules based on editorconfig files
    pkgs.vimPlugins.editorconfig-vim

    # Git commands
    pkgs.vimPlugins.fugitive

    # Fuzzy finding
    pkgs.vimPlugins.fzf-vim

    # Language server client
    pkgs.vimPlugins.LanguageClient-neovim

    # Enhanced spelling and grammar checking
    pkgs-unstable.vimPlugins.vim-lexical

    # Provides tree based file explorer
    pkgs.vimPlugins.nerdtree

    # Restores cursor position on opening previously opened files
    pkgs-unstable.vimPlugins.restore-view-vim

    # Format text into one line per sentance
    pkgs-unstable.vimPlugins.vim-sentence-chopper

    # Provides syntax checking
    pkgs.vimPlugins.syntastic

    # Tab completion
    pkgs.vimPlugins.supertab

    # Provides ctags based navigation of current file
    pkgs.vimPlugins.tagbar

    # Query and insert unicode characters
    pkgs.vimPlugins.unicode-vim

    # Provides powerline style status line
    pkgs.vimPlugins.vim-airline
    pkgs.vimPlugins.vim-airline-themes

    # Invokes code formatting tools from Vim
    pkgs.vimPlugins.vim-autoformat

    # Provides easy line/block comment toggling
    pkgs.vimPlugins.vim-commentary

    # File query/modification commands
    pkgs.vimPlugins.vim-eunuch

    # Syntax highlighting
    pkgs.vimPlugins.vim-polyglot
    pkgs.vimPlugins.vim-openscad
    pkgs.vimPlugins.vim-nftables
    pkgs.vimPlugins.ron-vim
  ];
}
