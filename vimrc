" vundle start
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

" load plugins
call vundle#begin()

" required
Plugin 'gmarik/Vundle.vim'

" file/window organization
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'nixprime/cpsm'
Plugin 'szw/vim-ctrlspace'
Plugin 'rking/ag.vim'

" utilities
" Plugin 'jiangmiao/auto-pairs'
Plugin 'vimwiki/vimwiki'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'mattn/emmet-vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'junegunn/goyo.vim'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'

" languages
Plugin 'posva/vim-vue'
Plugin 'othree/html5.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'StanAngeloff/php.vim'
Plugin 'jwalton512/vim-blade'
Plugin 'vim-ruby/vim-ruby'
Plugin 'pangloss/vim-javascript'

" colorschemes
Plugin 'w0ng/vim-hybrid'
Plugin 'vim-scripts/summerfruit256.vim'
Plugin 'chriskempson/base16-vim'

call vundle#end()
filetype plugin indent on
syntax on

" leader to comma
let mapleader=","

" show indention when wrapping
set breakindent

" basic formatting
set autoindent
set ruler
set hidden

" faster performance
" let html_no_rendering=1 " Don't render italic, bold, links in HTML
" let loaded_matchparen=1 " Don't load matchit.vim (paren/bracket matching)
set noshowmatch         " Don't match parentheses/brackets
set nocursorline        " Don't paint cursor line
set nocursorcolumn      " Don't paint cursor column

" decrease escape timeout
set timeoutlen=500
set ttimeoutlen=0

" relative line numbers
set number
set norelativenumber
set display=lastline

" spacing & whitespace
set tabstop=2
set shiftwidth=2
set textwidth=0
set wrapmargin=0
set nowrap
set linebreak
set nolist
set backspace=indent,eol,start
set expandtab

" list chars
set listchars=""
set listchars=tab:>-
set listchars+=trail:.
set listchars+=extends:>
set listchars+=precedes:<

" folding/searching
set hlsearch
set incsearch
set ignorecase
set foldmethod=manual

" dont use buffer saving
set nobackup
set noswapfile

" no cursor line highlight
set nocursorline
set nocursorcolumn

" more natural split resizing
set splitbelow
set splitright

set fillchars+=vert:│ 

" simpler airline display
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline_left_sep = ''
let g:airline_left_alt_sep = '┃'
let g:airline_right_sep = ''
let g:airline_right_alt_sep = '┃'
let g:indentLine_faster = 1
let g:indentLine_leadingSpaceChar = '∙'
let g:indentLine_char = '│'
let g:indentLine_first_char = '│'
let g:indentLine_fileTypeExclude = ['', 'qf', 'gitv', 'tagbar', 'vimfiler', 'unite', 'help', 'man', 'gitcommit', 'vimwiki', 'notes']

" status bar is hidden if only one split
set laststatus=1

" often i want to make a new line above the one i'm inputting
:imap kk <esc>O
:imap jj <esc>o

" dont show the tab line
set showtabline=1

" disable output and vcs files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" ignore librarian-chef, vagrant, test-kitchen and berkshelf cache
set wildignore+=*/tmp/librarian/*,*/.vagrant/*,*/.kitchen/*,*/vendor/cookbooks/*

" ignore rails temporary asset caches
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*

" disable temp and backup files
set wildignore+=*.swp,*~,._*

" copy to my osx clipboard, we also need reattach plugin here if using tmux
set clipboard=unnamed

" dont fold markdown
let g:vim_markdown_folding_disabled = 1

" fix syntax highlighting in mixed files
autocmd BufEnter * :syntax sync fromstart

" open a new tab
:nnoremap <C-S-t> :tabnew<CR>

:nnoremap Ò :bn<CR>
:nnoremap Ó :bp<CR>
:nnoremap Ô :tabn<CR>
:nnoremap  :tabp<CR>

" vimrc refresh automatically
augroup myvimrc
  au!
  au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc,.vimrc_background so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
:nnoremap <leader><leader>r :so $MYVIMRC<CR>

" change shift width quickly
:noremap <leader>w2 :set tabstop=2 shiftwidth=2<CR>
:noremap <leader>w4 :set tabstop=4 shiftwidth=4<CR>

" quickly edit vimrc
:noremap <leader>ve :tabedit ~/.vimrc<CR>

" show current file full path
:nnoremap <leader>fn :echo expand('%:p')<CR>

" relative number toggling
:nnoremap <leader>rn :call NumToggle()<CR>

" better copying
:vnoremap <silent> y y`]
:vnoremap <silent> p p`]
:nnoremap <silent> p p`]
:noremap gV `[v`]
:nnoremap <silent> p p`]
:nnoremap <silent> p p`]

" format json
:nnoremap <leader>fj :%!python -m json.tool<CR>

function! NumToggle()
    set relativenumber!
    if (&relativenumber > 0)
        set nonumber
    else
        set number
    endif
endfunction

" vertical resize
:nnoremap = :res +10<CR>
:nnoremap - :res -10<CR>

" horizontal resize
:nnoremap + :vertical res +10<CR>
:nnoremap _ :vertical res -10<CR>

" easier window motions with leader
:nnoremap ¬ :wincmd l<CR>
:nnoremap ˙ :wincmd h<CR>
:nnoremap ∆ :wincmd j<CR>
:nnoremap ˚ :wincmd k<CR>
:nnoremap <leader>w= :wincmd =<CR>

" quick function to toggle the tabline
:nnoremap <silent> <leader>tl :execute 'set showtabline=' . (&showtabline ==# 0 ? 2 : 0)<CR>

" quick function to toggle the status line
:nnoremap <silent> <leader>sl :execute 'set laststatus=' . (&laststatus ==# 1 ? 2 : 1)<CR>

" add space above/below current line
:nnoremap <leader>o o<esc>k
:nnoremap <leader>O O<esc>j

" visual selection of text on a line, not including the return char
:nnoremap <leader>vl ^v$h

" file saving
:noremap <Leader>s :update<CR>
:noremap <Leader>w :update<CR>
:noremap <Leader>wq :wq!<CR>
:noremap <Leader>bd :bd<CR>
:noremap <Leader>q :wincmd q<CR>
:noremap <Leader><leader>q :q!<CR>

" jumping around, i always want my cursor to be in the middle
:noremap <Leader><leader>q :q!<CR>
:noremap L Lzz
:noremap H Hzz

" toggle paste mode
nmap <leader><leader>p :set invpaste<CR>:set paste?<CR>
imap <leader><leader>p <ESC>:set invpaste<CR>:set paste?<CR>

" format the entire file
nnoremap <leader>fef :normal! gg=G``<CR>

" upper/lower format word without selection
nmap <leader>uc mQviwU`Q
nmap <leader>lc mQviwu`Q

" underline the current line with '='
nmap <silent> <leader>ul :t.<CR>Vr=

" set text wrapping toggles
nmap <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>:set linebreak<CR>

" find merge conflict markers
nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk

" flip single lines
nmap <C-k> [e
nmap <C-j> ]e

" flip multiple lines
vmap <C-k> [egv
vmap <C-j> ]egv

" remove trailing whitespaces
:nnoremap <leader>fws :FixWhitespace<CR>

" fix indentation to spaces
:nnoremap <leader>fi  ggVG>gv<<esc>

" multiple cursor don't exit until second escape
let g:multi_cursor_exit_from_visual_mode=0
let g:multi_cursor_exit_from_insert_mode=0

" toggle search highlighting
nmap <leader>hs :set hlsearch! hlsearch?<CR>

" function file, buffer, mru search
:nnoremap <C-I> :CtrlPBuffer<Cr>
:nnoremap <C-U> :CtrlPMRU<Cr>
:nnoremap <C-O> :CtrlPFunky<Cr>
:nnoremap <C-T> :CtrlPTag<Cr>
:nnoremap <leader>fu :CtrlPFunky<Cr>
:nnoremap <leader>fp :CtrlP<Cr>

" more speedy startup of ctrlp
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command =
    \ 'ag %s --files-with-matches -g "" --ignore "*.min.js" --ignore "*.min.css" --ignore "node_modules" --ignore ".git"'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

else
  " Fall back to using git ls-files if Ag is not available
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$|node\_modules$'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}

" select entire file
:nnoremap <leader><leader>a ggVG

" change cursor to underscore on visual mode or insert mode.
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" use ~/.confg/base16-shell
if filereadable(expand("~/.vimrc_background"))
    set background=dark
    set t_Co=256
    let g:hybrid_custom_term_colors = 1
    let g:hybrid_reduced_contrast = 1
    let g:airline_theme = 'seth'
    source ~/.vimrc_background
    highlight LineNr ctermbg=NONE guibg=NONE
    hi Special ctermfg=9
    hi Function ctermfg=12
    hi Keyword ctermfg=13
    hi Include ctermfg=13
    hi Export ctermfg=13
    hi From ctermfg=13
    hi Statement ctermfg=13
    hi Search ctermbg=5
    hi link CtrlSpaceNormal Normal
    hi link CtrlSpaceSelected Visual
    hi link CtrlSpaceStatus Ctrlpdark
    hi MatchParen ctermbg=0
endif

" nerdtree settings
let NERDTreeQuitOnOpen = 1
map <leader>n :NERDTreeToggle<CR>
map <leader>m :NERDTreeFind<CR>
let NERDTreeHijackNetrw=0
let NERDTreeMapOpenVSplit='v'
let NERDTreeMapOpenSplit='s'

" if the opening parameter is a directory, cd into it
augroup AuNERDTreeCmd
autocmd AuNERDTreeCmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
autocmd AuNERDTreeCmd FocusGained * call s:UpdateNERDTree()

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

map <leader>G :Goyo<CR>

" Goyo options
function! s:goyo_enter()
    set wrap
    set textwidth=0
    set nocp
    set linebreak
    set nolist
    set showbreak=
    nohlsearch
endfunction

function! s:goyo_leave()
    set showbreak=\ \ 
    set nowrap
    hi LineNr ctermbg=NONE guibg=NONE
    hi link CtrlSpaceNormal Normal
    hi link CtrlSpaceSelected Visual
    hi link CtrlSpaceStatus Ctrlpdark
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

function! StrongTerms(...)
    execute "%s/\d\+\.\s.\{-}\./<strong>\0<\/strong>/g"
endfunction

" fix shift-spc mapping (requires iterm2 key setup)
:nmap ✠ <Plug>VimwikiSplitLink
:vmap ✠ <Plug>VimwikiSplitLink

" fix ctrl-spc mapping (requires iterm2 key setup)
:nmap ¥ <Plug>VimwikiVSplitLink
:vmap ✠ <Plug>VimwikiVSplitLink

" Use markdown instead of wiki lang
let g:vimwiki_list = [{'path': '$HOME/Dropbox/wiki', 'syntax': 'markdown', 'ext': '.md', 'nested_syntaxes': {'html': 'html', 'javascript': 'javascript', 'css': 'css', 'php': 'php', 'bash': 'bash'}}]

let g:snipMate = get(g:, 'snipMate', {}) " Allow for vimrc re-sourcing
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['vue'] = 'javascript,css,html,scss'
