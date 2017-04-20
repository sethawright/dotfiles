" vundle start
set nocp
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

" load plugins
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'vim-ctrlspace/vim-ctrlspace'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'nixprime/cpsm'
Plugin 'rking/ag.vim'
Plugin 'vimwiki/vimwiki'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'jiangmiao/auto-pairs'
Plugin 'mattn/emmet-vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'junegunn/goyo.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'posva/vim-vue'
Plugin 'jwalton512/vim-blade'
Plugin 'pangloss/vim-javascript'
Plugin 'StanAngeloff/php.vim'
Plugin 'vim-airline/vim-airline'
call vundle#end()

filetype plugin indent on
syntax on

" leader to comma
let mapleader=","

set timeoutlen=500
set ttimeoutlen=0

" various config
set backspace=indent,eol,start
set breakindent
set autoindent
set ruler
set hidden
set nonumber
set relativenumber
set display=lastline
set tabstop=2
set shiftwidth=2
set nowrap
set textwidth=0
set linebreak
set nolist
set expandtab
set noswapfile
set nocursorline
set hlsearch
set incsearch
set ignorecase
set foldmethod=manual

" show hidden characters i usually dont want
set listchars=""
set listchars=tab:>-
set listchars+=trail:.
set listchars+=extends:>
set listchars+=precedes:<

" split resizing that makes sense to me
set splitbelow
set splitright

" cleaner split markers
set fillchars+=vert:│

" status bar is hidden if only one split
set laststatus=1

" helps for finding files
set wildmode=full
set wildmenu
set wildignorecase
set wildcharm=<C-z>

" disable output and vcs files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" ignore librarian-chef, vagrant, test-kitchen and berkshelf cache
set wildignore+=*/tmp/librarian/*,*/.vagrant/*,*/.kitchen/*,*/vendor/cookbooks/*

" ignore node modules, etc
set wildignore+=*/node_modules/*

" ignore rails temporary asset caches
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*

" disable temp and backup files
set wildignore+=*.swp,*~,._*

" copy to my osx clipboard, we also need reattach plugin here if using tmux
set clipboard=unnamed

" open a new tab
:nnoremap <c-t> :tabnew<CR>

" buffer navigation
:nnoremap Ò :bn<CR>
:nnoremap Ó :bp<CR>
:nnoremap Ô :tabn<CR>
:nnoremap  :tabp<CR>

" change shift width quickly
:noremap <leader>w2 :set tabstop=2 shiftwidth=2<CR>
:noremap <leader>w4 :set tabstop=4 shiftwidth=4<CR>

" quickly switch buffers
nnoremap <leader>b :ls<CR>:b<Space>
nnoremap <leader>s :ls<CR>:sb<Space>
nnoremap <leader>v :ls<CR>:vertical<Space>sb<Space>
nnoremap <leader>bb :b <C-z><S-Tab>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bp :bp<CR>
nnoremap <leader>ss :sb <C-z><S-Tab>
nnoremap <leader>vv :vertical sb <C-z><S-Tab>

" find files
set path=.,**
nnoremap <leader>ff :find *
nnoremap <leader>fs :sfind *
nnoremap <leader>fv :vert sfind *
nnoremap <leader>ft :tabfind *

" netrw settings
let g:netrw_liststyle = 3
let g:netrw_banner = 0

" ag is much faster at finding files than ctrlp defaults
if executable('ag')
  let g:ctrlp_user_command =
        \ 'ag %s --files-with-matches -g "" --ignore "*.min.js" --ignore "*.min.css" --ignore "node_modules" --ignore ".git"'
  let g:ctrlp_use_caching = 0
else
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$|node\_modules$'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

" cspm is a faster matcher in c
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}

" show current file full path
:nnoremap <leader>fp :echo expand('%:p')<CR>

" relative number toggling
function! NumToggle()
  set relativenumber!
  if (&relativenumber > 0)
    set nonumber
  else
    set number
  endif
endfunction
nnoremap <leader>rn :call NumToggle()<CR>

" better copying
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]
noremap gV `[v`]
nnoremap <silent> p p`]
nnoremap <silent> p p`]

" vertical resize
nnoremap = :res +10<CR>
nnoremap - :res -10<CR>

" horizontal resize
nnoremap + :vertical res +10<CR>
nnoremap _ :vertical res -10<CR>

" easier window motions with leader
nnoremap ¬ :wincmd l<CR>
nnoremap ˙ :wincmd h<CR>
nnoremap ∆ :wincmd j<CR>
nnoremap ˚ :wincmd k<CR>
nnoremap <leader>w= :wincmd =<CR>

" visual selection of text on a line, not including the return char
nnoremap <leader>vl ^v$h

" file saving
noremap <leader>w :update<CR>
noremap <leader>wq :wq!<CR>
noremap <leader>bd :bd<CR>
noremap <leader>q :wincmd q<CR>

" surround with tag
nnoremap <leader>st <leader>vl<C-Y>,

" format the entire file
nnoremap <leader>fef :normal! gg=G``<CR>

" text wrapping toggles
nnoremap <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>:set linebreak<CR>

" find merge conflict markers
nnoremap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" map the arrow keys to be based on display lines, not physical lines
noremap <Down> gj
noremap <Up> gk

" flip single lines
nmap <C-k> [e
nmap <C-j> ]e

" flip multiple lines
vmap <C-k> [egv
vmap <C-j> ]egv

" remove trailing whitespaces
nnoremap <leader>fws :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>:update<CR>

" fix indentation to spaces
nnoremap <leader>fi ggVG>gv<<esc>

" toggle search highlighting
nnoremap <leader>hs :set hlsearch! hlsearch?<CR>

" find functions
nnoremap <C-o> :CtrlPFunky<Cr>

" show hidden files
let g:ctrlp_show_hidden = 1

" clean up tab display
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" more speedy startup of ctrlp
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command =
        \ 'ag %s --files-with-matches --hidden -g "" --ignore "*.min.js" --ignore "*.min.css" --ignore "node_modules" --ignore ".git*"'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

else
  " Fall back to using git ls-files if Ag is not available
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$|node\_modules$'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

" select entire file
nnoremap <leader><leader>a ggVG

" change cursor to underscore on visual mode or insert mode.
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

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
  hi SignColumn guibg=NONE ctermbg=NONE
  hi link CtrlSpaceNormal Normal
  hi link CtrlSpaceSelected Visual
  hi link CtrlSpaceStatus Ctrlpdark
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" nerdtree settings
nnoremap <leader>n :Vexplore .<CR>
nnoremap <leader><leader>n :Explore .<CR>

" convert current markdown file to html in a new tab
nnoremap <leader>md :tabnew \| exec "read !marked --gfm " . shellescape(@#, 1)<CR>

" Use markdown instead of wiki lang
let g:vimwiki_list = [{'path': '$HOME/Dropbox/wiki', 'syntax': 'markdown', 'ext': '.md', 'nested_syntaxes': {'html': 'html', 'javascript': 'javascript', 'css': 'css', 'php': 'php', 'bash': 'sh'}}]
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'javascript', 'php', 'ruby', 'shell=sh', 'js=javascript', 'c', 'vim']

" find syntax highlighting for the current text object
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" set background based on terminal active theme
if filereadable(expand("~/.vimrc_background"))
  set t_Co=256
  source ~/.vimrc_background
endif

" vimrc refresh automatically
augroup myvimrc
  au!
  au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc,.vimrc_background so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" vimrc refresh
:nnoremap <leader><leader>r :so $MYVIMRC<CR>
