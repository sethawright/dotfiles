set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'wesQ3/vim-windowswap'
Plugin 'kien/ctrlp.vim'
Plugin 'StanAngeloff/php.vim'
Plugin 'szw/vim-ctrlspace'
Plugin 'mileszs/ack.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-surround'
Plugin 'chriskempson/base16-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'mattn/emmet-vim'
Plugin 'godlygeek/tabular'
Plugin 'tomtom/tcomment_vim'
Plugin 'jeroenbourgois/vim-actionscript'
Plugin 'kchmck/vim-coffee-script'
Plugin 'plasticboy/vim-markdown'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'reedes/vim-colors-pencil'
Plugin 'vim-scripts/xoria256.vim'
Plugin 'w0ng/vim-hybrid'
Plugin 'nanotech/jellybeans.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'captbaritone/better-indent-support-for-php-with-html'
Plugin 'xsbeats/vim-blade'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'chrisbra/csv.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'pangloss/vim-javascript'

call vundle#end()

filetype plugin indent on
let mapleader=","
syntax on

" Basic Formatting
set t_Co=256
set smartindent
set ruler
set hidden
set nonumber relativenumber

" Spacing & Whitespace
set tabstop=4
set shiftwidth=4
set textwidth=0
set wrapmargin=0
set nowrap
set linebreak
set nolist
set backspace=indent,eol,start
set expandtab

" List Chars
set listchars=""
set listchars=tab:>-
set listchars+=trail:.
set listchars+=extends:>
set listchars+=precedes:<

" Folding/Searching
set hlsearch
set incsearch
set ignorecase
set foldmethod=manual

" Dont use buffers
set nobackup
set noswapfile

" Airline is nice for if im using splits
" Status bar is hidden otherwise
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = ' '
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = ' '
set laststatus=2

" Hide the status bar completely
" set noshowmode
" set noru
" set laststatus=2

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Ignore librarian-chef, vagrant, test-kitchen and Berkshelf cache
set wildignore+=*/tmp/librarian/*,*/.vagrant/*,*/.kitchen/*,*/vendor/cookbooks/*

" Ignore rails temporary asset caches
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*

" Mouse on
" set mouse=a
" map <ScrollWheelUp> <C-Y>
" map <ScrollWheelDown> <C-E>

" No markdown folding
let g:vim_markdown_folding_disabled=1

" Not using tabs in lieu of CtrlSpace
set showtabline=0

" Copy to my osx clipboard
set clipboard=unnamed

" Allow more/less time for leader
set timeoutlen=500
set ttimeoutlen=50

" Tab Navigation
:nnoremap <C-S-t> :tabnew<CR>
:nnoremap <leader>l :bn<CR>
:nnoremap <leader>h :bp<CR>

" Yank to end of selection
:vmap Y y`]o<esc>p

" Vimrc Refresh
:nnoremap <leader>vr :source ~/.vimrc<CR>
:nnoremap <leader>ve :tabedit ~/.vimrc<CR>

" Show Current File Path
:nnoremap <leader>fn :echo expand('%:p')<CR>

" more natural split resizing
set splitbelow
set splitright

" change to absolute numbering
:nnoremap <leader>rn :set nonumber relativenumber<CR>
:nnoremap <leader>rN :set number norelativenumber<CR>

" vertical resize
:nnoremap = :res +10<CR>
:nnoremap - :res -10<CR>

" horizontal resize
:nnoremap + :vertical res +10<CR>
:nnoremap _ :vertical res -10<CR>

" easier window motions
:nnoremap <leader>wl :wincmd l<CR>
:nnoremap <leader>wh :wincmd h<CR>
:nnoremap <leader>wj :wincmd j<CR>
:nnoremap <leader>wk :wincmd k<CR>
:nnoremap <leader>w= :wincmd =<CR>

" Add space above/below
:nnoremap <leader>o o<esc>k
:nnoremap <leader>O O<esc>j

" Visual selection of text on a line
:nnoremap <leader>vl ^v$h

" File saving
:noremap <Leader>s :update<CR>
:noremap <Leader>w :update<CR>
:noremap <Leader>wq :wq!<CR>
:noremap <Leader>bd :bd<CR>
:noremap <Leader>q :wincmd q<CR>
:noremap <Leader><leader>q :q!<CR>

" Toggle paste mode
nmap <leader><leader>p :set invpaste<CR>:set paste?<CR>
imap <leader><leader>p <ESC>:set invpaste<CR>:set paste?<CR>

" format the entire file
nnoremap <leader>fef :normal! gg=G``<CR>

" upper/lower word
nmap <leader>uc mQviwU`Q
nmap <leader>lc mQviwu`Q

" Underline the current line with '='
nmap <silent> <leader>ul :t.<CR>Vr=

" set text wrapping toggles
nmap <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>:set linebreak<CR>

" set wrap linebreak nolist
" even on wrap, i only want to go one line
noremap <buffer> <silent> k gk
noremap <buffer> <silent> j gj

" find merge conflict markers
nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" Map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
nmap <C-k> [e
nmap <C-j> ]e

" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv
vmap <C-k> [egv
vmap <C-j> ]egv

" Toggle hlsearch with <leader>hs
nmap <leader>hs :set hlsearch! hlsearch?<CR>

" Function and file search
:nnoremap <C-I> :CtrlPBuffer<Cr>
:nnoremap <C-U> :CtrlPMRU<Cr>
:nnoremap <C-O> :CtrlPFunky<Cr>
:nnoremap <leader>fu :CtrlPFunky<Cr>
:nnoremap <leader>fp :CtrlP<Cr>
let g:ctrlp_max_files=30000

" GoldenView
nmap <silent> <C-L>  <Plug>GoldenViewSplit
nmap <silent> <F8>   <Plug>GoldenViewSwitchMain
nmap <silent> <S-F8> <Plug>GoldenViewSwitchToggle

" Environment Switching
:nnoremap <leader>efd :call SetSethEnv('freelance', 'dark')<Cr>
:nnoremap <leader>efl :call SetSethEnv('freelance', 'light')<Cr>
:nnoremap <leader>ewd :call SetSethEnv('work', 'dark')<Cr>
:nnoremap <leader>ewl :call SetSethEnv('work', 'light')<Cr>
:nnoremap <leader>eod :call SetSethEnv('other', 'dark')<Cr>
:nnoremap <leader>eol :call SetSethEnv('other', 'light')<Cr>
:nnoremap <leader>fws :FixWhitespace<CR>
:nnoremap <leader>fi  ggVG>gv<<esc>

" Select all
:nnoremap <leader><leader>a ggVG

" Tasks
:nnoremap <leader>ta Go[ ]
:nnoremap <leader>tc mz0lrx`z
:nnoremap <leader>tm mz0lr-`z
:nnoremap <leader>tu mz0lr `z

function! SetSethEnv(env, bg)
    if(a:bg == 'dark')
        set background=dark
    else
        set background=light
    endif

    if a:env == 'work'
        colorscheme base16-google

        " Insert mdoe has a thinner, yellow cursor
        " allowing me to avoid any sort of
        " status line indicator taking up unnecessary space
        if exists('$TMUX')
            " let &t_EI = "\<Esc>Ptmux;\<Esc>\033]Pl3971ED\033\\\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
            " let &t_SI = "\<Esc>Ptmux;\<Esc>\033]PlFBA922\033\\\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"

            " let &t_EI = "\<Esc>Ptmux;\<Esc>\033]Pl3971ED\033\\"
            " let &t_SI = "\<Esc>Ptmux;\<Esc>\033]PlFBA922\033\\"
            " autocmd VimLeave * silent !echo -ne "\033]Pl3971ED\033\\"
        else
            " let &t_EI = "\033]Pl3971ED\033\\\<Esc>]50;CursorShape=0\x7"
            " let &t_SI = "\033]PlFBA922\033\\\<Esc>]50;CursorShape=1\x7"
            " autocmd VimLeave * silent !echo -ne "\033]Pl3971ED\033\\"
        endif

    elseif a:env =='freelance'
        " let g:hybrid_use_iTerm_colors = 1
        colorscheme hybrid
    else
        colorscheme solarized
    endif

    if(a:bg == 'dark')
        highlight LineNr ctermbg=NONE guibg=NONE
    else
        highlight LineNr ctermbg=NONE guibg=NONE
    endif

    " highlight TabLine ctermfg=blue ctermbg=NONE
    " highlight TabLineFill ctermbg=NONE
    " highlight TabLineSel ctermfg=cyan ctermbg=NONE

endfunction

autocmd BufNewFile,BufRead *.blade.php set ft=html | set ft=phtml | set ft=blade " Fix blade auto-indent

" Nerdtree
" let g:NERDTreeWinPos = "right"
let NERDTreeQuitOnOpen = 1
map <leader>n :NERDTreeToggle<CR>
let NERDTreeHijackNetrw=0

augroup AuNERDTreeCmd
autocmd AuNERDTreeCmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
autocmd AuNERDTreeCmd FocusGained * call s:UpdateNERDTree()

" If the parameter is a directory, cd into it
function! s:CdIfDirectory(directory)
    let explicitDirectory = isdirectory(a:directory)
    let directory = explicitDirectory || empty(a:directory)

    if explicitDirectory
      exe "cd " . fnameescape(a:directory)
    endif

    " Allows reading from stdin
    " ex: git diff | mvim -R -
    if strlen(a:directory) == 0
      return
    endif

    if directory
      NERDTree
      wincmd p
      bd
    endif

    if explicitDirectory
      wincmd p
    endif
endfunction

" NERDTree utility function
function! s:UpdateNERDTree(...)
    let stay = 0

    if(exists("a:1"))
      let stay = a:1
    end

    if exists("t:NERDTreeBufName")
      let nr = bufwinnr(t:NERDTreeBufName)
      if nr != -1
        exe nr . "wincmd w"
        exe substitute(mapcheck("R"), "<CR>", "", "")
        if !stay
          wincmd p
        end
      endif
    endif
endfunction

:call SetSethEnv('work', 'dark')
