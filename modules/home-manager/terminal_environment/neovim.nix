{
  inputs,
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    extraPackages = [
      pkgs.universal-ctags
      pkgs-unstable.nixd
    ];

    plugins = [
      # Colour scheme
      (pkgs.vimPlugins.base16-vim.overrideAttrs (
        old: let
          schemeFile = config.scheme inputs.base16-vim;
        in {patchPhase = ''cp ${schemeFile} colors/base16-scheme.vim'';}
      ))

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

    extraConfig = ''
      set nocompatible
      set encoding=utf-8

      filetype off

      " Restores cursor position on opening previously opened files
      "Plug 'https://github.com/vim-scripts/restore_view.vim'
      " Enhanced spelling and grammar checking
      "Plug 'https://github.com/reedes/vim-lexical'
      " Format text into one line per sentance
      "Plug 'https://github.com/Konfekt/vim-sentencewrap'

      """"""""""""""""""
      " GENERAL CONFIG "
      """"""""""""""""""

      filetype plugin indent on
      syntax on

      " Use Space as Leader
      let mapleader = " "

      " Tagbar config
      let g:tagbar_autofocus = 1
      let g:tagbar_compact = 1

      " Syntastic config
      let g:syntastic_mode_map = {
            \ 'mode': 'passive',
            \ 'active_filetypes': [],
            \ 'passive_filetypes': []
      \ }
      let g:syntastic_auto_loc_list = 1
      let g:syntastic_aggregate_errors = 1

      " Language server config
      let g:LanguageClient_serverCommands = {
            \ 'nix': ['nixd'],
            \ 'rust': ['rust-analyzer'],
      \ }

      " Spelling config
      let g:lexical#spell_key = '<leader>ss'
      let g:lexical#thesaurus_key = '<leader>st'
      let g:lexical#spelllang = ['en_gb']
      command Spell call lexical#init({'spell': 1})
      command SpellOff call lexical#init({'spell': 0})

      " Colour scheme
      set termguicolors background=dark
      let base16colorspace=256
      colorscheme base16-scheme

      " Terminal title
      set title

      " Airline config
      let g:airline_powerline_fonts = 1

      set laststatus=2
      set timeoutlen=500

      " Set tab width to 2 spaces
      set tabstop=2
      set shiftwidth=2
      set expandtab

      " Complete options (disable preview scratch window, limit popup items)
      set completeopt=menu,menuone,longest
      set pumheight=15

      " SuperTab option for context aware completion
      let g:SuperTabDefaultCompletionType = "context"

      " Set options to restore from last session
      set viewoptions=cursor,slash,unix

      " Don't use swap and backup files
      set noswapfile
      set nobackup
      set nowritebackup

      " Don't wrap on new line
      set nowrap
      set nolbr

      " Squelch bells
      set noerrorbells
      set novisualbell

      " Vim search config
      set incsearch
      set hlsearch

      " Show relative line numbers on left
      set number
      set relativenumber

      " Highlight current line
      set cursorline

      " NERDTree config
      let g:NERDTreeChDirMode = 2 " Change working dir to NERDTree dir
      let g:NERDTreeMinimalUI = 1

      """""""""""""""""""""""""""""""
      " MISC COMMANDS AND FUNCTIONS "
      """""""""""""""""""""""""""""""

      " Enable or disable text wrapping
      command! NoTextWrap :set formatoptions-=t
      command! TextWrap :set formatoptions+=t

      """"""""""""""""
      " KEY MAPPINGS "
      """"""""""""""""

      " Language server menu
      nmap <Leader>l <Plug>(lcn-menu)

      " Handy shortcut for replacing words
      map <Leader>r :%s/\<<C-r><C-w>\>/

      " Syntax checking
      map <Leader>c :SyntasticCheck<CR>
      map <Leader>C :SyntasticReset<CR>

      " Manual spelling toggle
      map <Leader>s :Spell<CR>
      map <Leader>S :SpellOff<CR>

      " Find shortcuts
      map <Leader>f :Files<CR>
      map <Leader>b :Buffers<CR>

      " easymotion word jumping
      map <Leader>j <Plug>(easymotion-bd-w)
      nmap <Leader>j <Plug>(easymotion-overwin-w)

      " Code format shortcut
      map <Leader>F :Autoformat<CR>

      " Toggle NERDTree
      map <Leader>n :NERDTreeToggle<CR>

      " Toggle tagbar
      map <Leader>t :TagbarToggle<CR>

      " Easy indent/unindent
      vmap < <gv
      vmap > >gv

      " Fast saving and exiting
      nmap <Leader>w :w<CR>
      nmap <Leader>x :x<CR>
      nmap <Leader>q :q<CR>
    '';
  };
}
