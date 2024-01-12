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

    # GitHub copilot integration
    vimPlugins.copilot-vim

    # Used to format and make editing CSV files trivial
    vimPlugins.csv

    # Fast jumping to markers in a file
    vimPlugins.easymotion

    # Applies formatting rules based on editorconfig files
    vimPlugins.editorconfig-vim

    # Fuzzy finding
    vimPlugins.fzf-vim

    # Language server client
    vimPlugins.LanguageClient-neovim

    # Enhanced spelling and grammar checking
    vimPlugins.vim-lexical

    # Provides tree based file explorer
    vimPlugins.nerdtree

    # Restores cursor position on opening previously opened files
    vimPlugins.restore-view-vim

    # Format text into one line per sentance
    vimPlugins.vim-sentence-chopper

    # Provides syntax checking
    vimPlugins.syntastic

    # Tab completion
    vimPlugins.supertab

    # Provides ctags based navigation of current file
    vimPlugins.tagbar

    # Query and insert unicode characters
    vimPlugins.unicode-vim

    # Provides powerline style status line
    vimPlugins.vim-airline
    vimPlugins.vim-airline-themes

    # Provides easy line/block comment toggling
    vimPlugins.vim-commentary

    # File query/modification commands
    vimPlugins.vim-eunuch

    # Syntax highlighting
    vimPlugins.vim-polyglot
    vimPlugins.vim-openscad
    vimPlugins.vim-nftables
  ];
}
