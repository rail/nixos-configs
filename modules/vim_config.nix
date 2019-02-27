{ pkgs ? import <nixpkgs> {}
}:

let
  preConfig = ''
    let mapleader = "\<Space>"
    let maplocalleader = ","
    scriptencoding utf-8
    set encoding=utf-8
    " Temp Files

    " Fuck swapfiles
    set noswapfile

    " Set backup/undo dirs
    set backupdir=~/.config/nvim/tmp/backups//
    set undodir=~/.config/nvim/tmp/undo//

    " Make the folders automatically if they don't already exist.
    if !isdirectory(expand(&backupdir))
      call mkdir(expand(&backupdir), 'p')
    endif

    if !isdirectory(expand(&undodir))
      call mkdir(expand(&undodir), 'p')
    endif

    " Persistent Undo, Vim remembers everything even after the file is closed.
    set undofile
    set undolevels=500
    set undoreload=500

    " Use the OS clipboard by default
    set clipboard+=unnamedplus

    " Enhance command-line completion
    set wildmenu
    set wildmode=longest,full
    set wildignore+=*/.hg/*,*/.git/*,*/.svn/*
    set wildignore+=*.gif,*.png,*.jp*
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip
    set wildignore+=*/.sass-cache/*,*.map

    " Saner backspacing
    set backspace=indent,eol,start

    " set esckeys
    set showcmd
    set autoread
    set hidden
    set noerrorbells

    " Don’t reset cursor to start of line when moving around.
    set nostartofline

    " scroll the screen before I rech the bottom
    set laststatus=2

    " Better auto complete
    set complete=.,w,b,u,t,i
    set completeopt=longest,menu,preview

    set nrformats-=octal
    set notimeout
    set nottimeout

    " More natural split opening
    set splitbelow
    set splitright


    " Mapping

    " Unmap space in normal and visual modes
    nnoremap <SPACE> <nop>
    vnoremap <SPACE> <nop>

    " Map ctrl c to escape to fix multiple cursors issue
    noremap <C-c> <Esc>

    " Map the capital equivalent for easier save/exit
    cabbrev Wq wq
    cabbrev W w
    cabbrev Q q

    " unmap capital K
    nnoremap K <nop>

    " Copies what was just pasted
    " Allows you to paste the same thing over and over and over and over and over and over
    xnoremap p pgvy

    " Cylces through splits using a double press of enter in normal mode
    nnoremap <CR><CR> <C-w><C-w>

    " Unmaps the arrow keys
    map <Up> <nop>
    map <Down> <nop>
    map <Left> <nop>
    map <Right> <nop>

    " Map ; to :
    noremap ; :

    " Maps Tab to indent blocks of text in visual mode
    vmap <TAB> >gv
    vmap <BS> <gv

    " use hjkl-movement between rows when soft wrapping:
    nnoremap j gj
    nnoremap k gk
    vnoremap j gj
    vnoremap k gk

    " include the default behaviour by doing reverse mappings so you can move linewise with gj and gk:
    nnoremap gj j
    nnoremap gk k

    " Jumps to the bottom of Fold
    nmap <Leader>b zo]z
    " and up
    nmap <Leader>u zo[z

    " Easily move to start/end of line
    nnoremap H 0
    nnoremap L $
    vnoremap H 0
    vnoremap L $

    " za/az toggle folds
    " ezpz to spam open/close folds now
    nmap az za

    " highlight all tabs and trailing whitespace characters
    highlight ExtraWhitespace ctermbg=red ctermfg=white guibg=#592929
    match ExtraWhitespace /\s\+$\|\t/
    " Spaces and Tabs {{{

    " Set indent to 4 spaces wide
    set tabstop=4
    set shiftwidth=4

    " A combination of spaces and tabs are used to simulate tab stops at a width
    set softtabstop=4
    set expandtab

    " Show “invisible” characters
    " set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_
    set listchars=tab:⇥\ ,trail:☠
    set list

    " }}}

    " Line Wrap {{{

    " Soft wraps lines without editing file
    set wrap

    " Stops words from being cut off during linebreak
    set linebreak

    " Set textwidth to 80 characters
    set textwidth=0
    set wrapmargin=0

    " Copy indent from previous line on linebreak
    set autoindent

    " Linebreaks keep indent level
    set breakindent

    " }}}

    " Look and Feel {{{

	" force minimun window width
	set winwidth=100

    " Enable true color for neovim
    let $NVIM_TUI_ENABLE_TRUE_COLOR = 0

    " Enables cursor similar to gui programs
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

    " Change window title to filename
    set title

    " use relative numbers
    set number relativenumber

    " Hide ruler
    set noruler

    " Don't redraw screen as often
    set lazyredraw

    set nocursorcolumn
    set nocursorline

    " syntax sync minlines=256
    " set synmaxcol=300
    " set re=1

    " Don’t show the intro message when starting Vim
    set shortmess=atIc

    " Hide mode indicator
    set noshowmode

    " scroll when reach 3rd line from the bottom
    set scrolloff=3

    " }}}

    " Searching {{{

    " Highlight search matches
    set hlsearch

    " Show search results as you type
    set incsearch

    " Ignore case in searches if query doesn't include capitals
    set ignorecase
    set smartcase

    " }}}
    " {{{ Tabs

    nnoremap <S-Left> :tabprevious<CR>
    nnoremap <S-Right> :tabnext<CR>
    nnoremap <silent> <S-A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
    nnoremap <silent> <S-A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

    " }}}
    " Better Buffer Navigation {{{
    " Maps <Tab> to cycle though buffers but only if they're modifiable.

    function! BetterBufferNav(bcmd)
        if &modifiable == 1 || &filetype ==? 'help'
            execute a:bcmd
        endif
    endfunction

    " Maps Tab and Shift Tab to cycle through buffers
    nmap <silent> <Tab> :call BetterBufferNav("bn") <Cr>
    nmap <silent> <S-Tab> :call BetterBufferNav("bp") <Cr>

    " }}}

    " Line Return {{{
    " Returns you to your position on file reopen and closes all folds.
    " On fold open your cursor is on the line you were at on the fold.
    augroup line_return
        au!
        autocmd BufReadPost * :call LineReturn()
    augroup END

    function! LineReturn()
        if line("'\"") > 0 && line("'\"") <= line('$')
            execute 'normal! g`"zvzzzm'
        endif
    endfunction

    " }}}

  '';
  postConfig = ''
  '';
  pluginsWithConfig = [

    # LANGUAGE SUPPORT (HIGHLIGHTING)
    { plugins = [
        # A collection of language packs for Vim.
        # https://github.com/sheerun/vim-polyglot
        "vim-polyglot"
        # Support for writing Nix expressions in vim.
        # https://github.com/LnL7/vim-nix
        "vim-nix"
        "vim-css-color"
      ];
      config = "";
    }

    # THEME
    { plugins = [
        "vim-one"
        "vim-airline"
        "vim-airline-themes"
        "vim-highlightedyank"
        "vim-signify"
      ];
      config = ''
        set termguicolors
        set background=dark
        colorscheme one
        let g:one_allow_italics = 1
        let g:airline_theme='one'
        let g:airline#extensions#tabline#enabled = 1
        let g:airline_powerline_fonts = 1
        let g:airline#extensions#tabline#formatter = 'unique_tail'
        let g:highlightedyank_highlight_duration = 200
      '';
    }

    # VERSION CONTROL
    { plugins = [
        # A Git wrapper
        # https://github.com/tpope/vim-fugitive
        "fugitive"
        # Plugin which manipulate gists in Vim.
        # https://github.com/lambdalisue/vim-gista
        "vim-gista"
      ];
      config = ''
      '';
    }

    # NAVIGATION
    { plugins = [
        # Plugin to toggle, display and navigate marks
        # https://github.com/kshenoy/vim-signature
        "vim-signature"
        # The fancy start screen for Vim.
        # https://github.com/mhinz/vim-startify
        "vim-startify"
      ];
      config = ''
        let g:startify_enable_special         = 0
        let g:startify_files_number           = 8
        let g:startify_relative_path          = 1
        let g:startify_change_to_dir          = 0
        let g:startify_update_oldfiles        = 1
        let g:startify_session_autoload       = 1
        let g:startify_session_persistence    = 1
        let g:startify_session_delete_buffers = 1

        let g:startify_list_order = [
          \ ['   Bookmarks:'],
          \ 'bookmarks',
          \ ['   Sessions:'],
          \ 'sessions',
          \ ['   Recent in this dir:'],
          \ 'dir',
          \ ['   Recent:'],
          \ 'files',
          \ ]

        let g:startify_bookmarks = [
          \ { 'c': '/etc/nixos/modules/vim_config.nix' },
          \ { 's': '~/work/git/services' },
          \ ]

        let g:startify_custom_footer =
          \ ["", "   Vim is charityware. Please read ':help uganda'.", ""]

        hi StartifyBracket ctermfg=240
        hi StartifyFile    ctermfg=147
        hi StartifyFooter  ctermfg=240
        hi StartifyHeader  ctermfg=114
        hi StartifyNumber  ctermfg=215
        hi StartifyPath    ctermfg=245
        hi StartifySlash   ctermfg=240
        hi StartifySpecial ctermfg=240
      '';
    }

    # EDITING
    { plugins = [
        # AutoSave - automatically save changes to disk without having to
        # use :w (or any binding to it) every time a buffer has been modified.
        # https://github.com/vim-scripts/vim-auto-save
        "vim-auto-save"
        "vim-expand-region"
        "vim-commentary"
        "vim-orgmode"
      ];
      config = ''
        " Use region expanding
        vmap v <Plug>(expand_region_expand)
        vmap <C-v> <Plug>(expand_region_shrink)

        " toggle spelling
        set invspell
        nnoremap <leader>s :set invspell<CR>
      '';
    }

    # MISC
    { plugins = [
        "ctrlp-vim"
        "vim-signify"
      ];
      config =''
      '';
    }

    # LINTING
    { plugins = [
        "ale"
      ];
      config =''
        let g:ale_lint_on_save = 1
        let g:ale_lint_on_text_changed = 1
        let g:ale_lint_on_enter = 1
        let g:ale_sign_error = '●'
        let g:ale_sign_warning = '.'
        let g:ale_python_flake8_options = "--max-line-length=110"
        " airline thingy
        let g:airline#extensions#ale#enabled = 1
        nmap <silent> <C-n> <Plug>(ale_next_wrap)
        nmap <silent> <C-N> <Plug>(ale_previous_wrap)
      '';
    }

    #  COMPLETION
    { plugins = [
        "deoplete-nvim"
        "deoplete-jedi"
        "deoplete-ternjs"
        "jedi-vim"
      ];
      config =''
        let g:deoplete#enable_at_startup = 1
        let g:deoplete#auto_complete_delay = 0
        inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
      '';
    }

    # "neoformat"
    # "UltiSnips"
    # "vim-snippets"
    # "fzf-vim"
    # "fzfWrapper"
    # "neomake"
    # lessspace
  ];
in {
  customRC = preConfig +
             (builtins.concatStringsSep "\n\n" (builtins.map (x: x.config) pluginsWithConfig)) +
             postConfig;
  packages.myVimPackages = {
    start = map (name: pkgs.vimPlugins."${name}") (pkgs.lib.flatten (builtins.map (x: x.plugins) pluginsWithConfig));
  };
}
