{...}: {
  programs.neovim.extraConfig = ''
    set nocompatible
    set encoding=utf-8

    filetype off

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
    let g:airline#extensions#ale#enabled = 1

    set laststatus=2
    set timeoutlen=500

    " Set tab width to 2 spaces
    set tabstop=2
    set shiftwidth=2
    set expandtab

    " Complete options (disable preview scratch window, limit popup items)
    set completeopt=menu,menuone,longest
    set pumheight=15

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
    let g:NERDTreeMinimalUI = 1

    function! NERDTreeOpen()
      if @% == ""
        NERDTreeCWD
      else
        NERDTreeFind
      endif
    endfunction

    """""""""""""""""""""""""""""""
    " MISC COMMANDS AND FUNCTIONS "
    """""""""""""""""""""""""""""""

    " Enable or disable text wrapping
    command! NoTextWrap :set formatoptions-=t
    command! TextWrap :set formatoptions+=t

    """"""""""""""""
    " KEY MAPPINGS "
    """"""""""""""""

    " Handy shortcut for replacing words
    map <Leader>r :%s/\<<C-r><C-w>\>/

    " Manual spelling toggle
    map <Leader>s :Spell<CR>
    map <Leader>S :SpellOff<CR>

    " Find shortcuts
    map <Leader>F :FzfLua<CR>
    map <Leader>f :FzfLua git_files<CR>
    map <Leader>b :FzfLua buffers<CR>
    map <Leader>g :FzfLua live_grep<CR>
    map <Leader>l :FzfLua lines<CR>
    map <Leader>c :FzfLua commands<CR>
    nmap cf :FzfLua lsp_finder<CR>
    nmap ca :FzfLua lsp_code_actions<CR>

    " easymotion word jumping
    map <Leader>j <Plug>(easymotion-bd-w)
    nmap <Leader>j <Plug>(easymotion-overwin-w)

    " NERDTree
    map <Leader>n :call NERDTreeOpen()<CR>
    map <Leader>N :NERDTreeClose<CR>

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
}
