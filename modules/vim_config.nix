{ pkgs ? import <nixpkgs> {}
}:

let
  preConfig = ''
    let mapleader = "\<Space>"
    let maplocalleader = ","
    scriptencoding utf-8
    set encoding=utf-8
    set noswapfile
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

    set showcmd
    set autoread
    set hidden
    set noerrorbells

    " Don’t reset cursor to start of line when moving around.
    set nostartofline

    " scroll the screen before I rech the bottom
    set laststatus=2

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
    " highlight ExtraWhitespace ctermbg=red ctermfg=white guibg=#592929
    " match ExtraWhitespace /\s\+$\|\t/
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

    " use relative numbers
    set number relativenumber

    " Hide ruler
    set noruler

    " Don't redraw screen as often
    set lazyredraw

    set nocursorcolumn
    set nocursorline

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
        "rust-vim"
        # "LanguageClient-neovim"
      ];
      config = ''
          "let g:LanguageClient_serverCommands = {
          "  \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
          "  \ 'python': ['pyls'],
          "\ }
          "let g:LanguageClient_useVirtualText = 0
          "set completefunc=LanguageClient#complete
          "" set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
          "nnoremap <F5> :call LanguageClient_contextMenu()<CR>
          "" Or map each action separately
          "nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
          "nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
          "nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
      '';
    }

    # THEME
    { plugins = [
        "vim-airline"
        "vim-airline-themes"
        "vim-highlightedyank"
        "vim-signify"
        "base16-vim"
      ];
      config = ''
        set termguicolors
        set background=dark
        colorscheme base16-oceanicnext
        let g:one_allow_italics = 1
        let g:airline_theme='base16_oceanicnext'
        let g:airline#extensions#tabline#enabled = 1
        let g:airline_powerline_fonts = 1
        let g:airline#extensions#tabline#formatter = 'unique_tail'
        let g:highlightedyank_highlight_duration = 200
        "let g:autofmt_autosave = 1
        "let g:rustfmt_autosave = 1
        "let g:rustfmt_emit_files = 1
        "let g:rustfmt_fail_silently = 0
        " let g:rust_clip_command = 'xclip -selection clipboard'
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
        autocmd VimEnter *
                \   if !argc()
                \ |   Startify
                \ |   wincmd w
                \ | endif
        let g:startify_enable_special         = 0
        let g:startify_files_number           = 8
        let g:startify_relative_path          = 1
        let g:startify_change_to_dir          = 0
        let g:startify_update_oldfiles        = 1
        let g:startify_session_autoload       = 1
        let g:startify_session_persistence    = 1
        let g:startify_session_delete_buffers = 1

        let g:startify_list_order = [
          \ ['   Sessions:'],
          \ 'sessions',
          \ ['   Recent in this dir:'],
          \ 'dir',
          \ ['   Recent:'],
          \ 'files',
          \ ['   Bookmarks:'],
          \ 'bookmarks',
          \ ]

        let g:startify_bookmarks = [
          \ { 'c': '/etc/nixos/modules/vim_config.nix' },
          \ { 's': '~/work/git/shipit' },
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
        "vim-better-whitespace"
        "vim-surround"
        "undotree"
      ];
      config = ''
        " Use region expanding
        vmap v <Plug>(expand_region_expand)
        vmap <C-v> <Plug>(expand_region_shrink)

        " toggle spelling
        set invspell
        nnoremap <leader>s :set invspell<CR>

        let g:better_whitespace_enabled=1
        let g:strip_whitespace_on_save=1
      '';
    }

    # MISC
    { plugins = [
        "fzf-vim"
      ];
      config =''
        nmap <silent> <C-p> :Files<CR>
        nmap <silent> <C-g> :BCommits<CR>
      '';
    }

    # LINTING
    # { plugins = [
    #     "ale"
    #   ];
    #   config =''
    #     let g:ale_lint_on_save = 1
    #     let g:ale_lint_on_text_changed = 1
    #     let g:ale_lint_on_enter = 1
    #     let g:ale_fixers = {
    #         \ 'rust': ['rustfmt'],
    #         \}
    #     let g:ale_fix_on_save = 1
    #     " airline thingy
    #     let g:airline#extensions#ale#enabled = 1
    #     nmap <silent> <C-n> <Plug>(ale_next_wrap)
    #     nmap <silent> <C-N> <Plug>(ale_previous_wrap)
    #   '';
    # }

    # #  COMPLETION
    # { plugins = [
    #     "jedi-vim"
    #   ];
    #   config =''
    #   '';
    # }

    # COC
    { plugins = [
        "coc-css"
        "coc-nvim"
        "coc-json"
        "coc-snippets"
        "coc-highlight"
        "coc-lists"
        "coc-pairs"
        "coc-yaml"
        "coc-yank"
        "coc-rls"
        "coc-python"
        "coc-html"
        "coc-tsserver"
        # "coc-fzf"
        "coc-tslint-plugin"
      ];
      config =''
        " TextEdit might fail if hidden is not set.
        set hidden

        " Some servers have issues with backup files, see #649.
        set nobackup
        set nowritebackup

        " Give more space for displaying messages.
        set cmdheight=2

        " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
        " delays and poor user experience.
        set updatetime=300

        " Don't pass messages to |ins-completion-menu|.
        set shortmess+=c

        " Always show the signcolumn, otherwise it would shift the text each time
        " diagnostics appear/become resolved.
        set signcolumn=yes

        " Use tab for trigger completion with characters ahead and navigate.
        " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
        " other plugin before putting this into your config.
        inoremap <silent><expr> <TAB>
              \ pumvisible() ? "\<C-n>" :
              \ <SID>check_back_space() ? "\<TAB>" :
              \ coc#refresh()
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

        function! s:check_back_space() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        " Use <c-space> to trigger completion.
        inoremap <silent><expr> <c-space> coc#refresh()

        " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
        " position. Coc only does snippet and additional edit on confirm.
        if exists('*complete_info')
          inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
        else
          imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
        endif

        " Use `[g` and `]g` to navigate diagnostics
        nmap <silent> [g <Plug>(coc-diagnostic-prev)
        nmap <silent> ]g <Plug>(coc-diagnostic-next)

        " GoTo code navigation.
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)

        " Use K to show documentation in preview window.
        nnoremap <silent> K :call <SID>show_documentation()<CR>

        function! s:show_documentation()
          if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
          else
            call CocAction('doHover')
          endif
        endfunction

        " Highlight the symbol and its references when holding the cursor.
        autocmd CursorHold * silent call CocActionAsync('highlight')

        " Symbol renaming.
        nmap <leader>rn <Plug>(coc-rename)

        " Formatting selected code.
        xmap <leader>f  <Plug>(coc-format-selected)
        nmap <leader>f  <Plug>(coc-format-selected)

        augroup mygroup
          autocmd!
          " Setup formatexpr specified filetype(s).
          autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
          " Update signature help on jump placeholder.
          autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        augroup end

        " Applying codeAction to the selected region.
        " Example: `<leader>aap` for current paragraph
        xmap <leader>a  <Plug>(coc-codeaction-selected)
        nmap <leader>a  <Plug>(coc-codeaction-selected)

        " Remap keys for applying codeAction to the current line.
        nmap <leader>ac  <Plug>(coc-codeaction)
        " Apply AutoFix to problem on the current line.
        nmap <leader>qf  <Plug>(coc-fix-current)

        " Introduce function text object
        " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
        xmap if <Plug>(coc-funcobj-i)
        xmap af <Plug>(coc-funcobj-a)
        omap if <Plug>(coc-funcobj-i)
        omap af <Plug>(coc-funcobj-a)

        " Use <TAB> for selections ranges.
        " NOTE: Requires 'textDocument/selectionRange' support from the language server.
        " coc-tsserver, coc-python are the examples of servers that support it.
        "nmap <silent> <TAB> <Plug>(coc-range-select)
        "xmap <silent> <TAB> <Plug>(coc-range-select)

        " Add `:Format` command to format current buffer.
        command! -nargs=0 Format :call CocAction('format')

        " Add `:Fold` command to fold current buffer.
        command! -nargs=? Fold :call     CocAction('fold', <f-args>)

        " Add `:OR` command for organize imports of the current buffer.
        command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

        " Add (Neo)Vim's native statusline support.
        " NOTE: Please see `:h coc-status` for integrations with external plugins that
        " provide custom statusline: lightline.vim, vim-airline.
        " set statusline^=%{coc#status()}%{get(b:,'coc_current_function',' ')}

        " Mappings using CoCList:
        " Show all diagnostics.
        nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
        " Manage extensions.
        nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
        " Show commands.
        nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
        " Find symbol of current document.
        nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
        " Search workspace symbols.
        nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
        "Do default action for next item.
        nnoremap <silent> <space>j  :<C-u>CocNext<CR>
        " Do default action for previous item.
        nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
        " Resume latest coc list.
        nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

        " FZF floating window
        let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
        let g:fzf_preview_window = 'right:65%'

        let g:coc_node_path = '${pkgs.nodejs}/bin/node'

        " Close preview window when completion is done.
        autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

        " You must set foldmethod=manual in your vimrc, one set Coc will handle
        " folding with the usual commands, zc, zo, etc
        set foldmethod=manual

        nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
      '';
    }
  ];
in {
  customRC = preConfig +
             (builtins.concatStringsSep "\n\n" (builtins.map (x: x.config) pluginsWithConfig)) +
             postConfig;
  packages.myVimPackages = {
    start = map (name: pkgs.vimPlugins."${name}") (pkgs.lib.flatten (builtins.map (x: x.plugins) pluginsWithConfig));
  };
}
