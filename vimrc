" vundle start
set nocp
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

" load plugins
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'arcticicestudio/nord-vim'
Plugin 'vimwiki/vimwiki'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-ctrlspace/vim-ctrlspace'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'nixprime/cpsm'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tomtom/tcomment_vim'
Plugin 'posva/vim-vue'
Plugin 'jwalton512/vim-blade'
Plugin 'pangloss/vim-javascript'
Plugin 'StanAngeloff/php.vim'
call vundle#end()

filetype plugin indent on
syntax on

" leader to comma
let mapleader=","

set timeoutlen=250
set ttimeoutlen=0

" various config
set backspace=indent,eol,start
set breakindent
set autoindent
set ruler
set hidden
set nonumber
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
set laststatus=0

" helps for finding files
set wildmode=longest:full,full
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

" change shift width quickly
:noremap ,w2 :set tabstop=2 shiftwidth=2<CR>
:noremap ,w4 :set tabstop=4 shiftwidth=4<CR>

" search for visually selected text
vnoremap // y/<C-R>"<CR>Nviw

" find files
set path=.,**
nnoremap ,f :find *
nnoremap ,s :sfind *
nnoremap ,v :vert sfind *
nnoremap ,t :tabfind *
nnoremap ,F :find <C-R>=expand('%:h').'/*'<CR>
nnoremap ,S :sfind <C-R>=expand('%:h').'/*'<CR>
nnoremap ,V :vert sfind <C-R>=expand('%:h').'/*'<CR>
nnoremap ,T :tabfind <C-R>=expand('%:h').'/*'<CR>

" buffer navigation
nnoremap gb :ls<CR>:buffer<Space>
nnoremap gB :ls<CR>:vert sb<space>
nnoremap ,b :buffer *
nnoremap ,,b :buffer *

" netrw/nt settings
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let NERDTreeMinimalUI = 1
let g:NERDTreeQuitOnOpen = 1
nnoremap ,n :NERDTreeToggle<CR>
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'
let NERDTreeShowHidden = 1

" mouse support -- hardly used but nice occasionally
set mouse=a

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

" file saving
noremap ,w :update<CR>
noremap ,wq :wq!<CR>
noremap ,q :wincmd q<CR>

" format the entire file
nnoremap ,,fef :normal! gg=G``<CR>

" text wrapping toggles
nnoremap <silent> ,,tw :set invwrap<CR>:set wrap?<CR>:set linebreak<CR>

" find merge conflict markers
nnoremap <silent> ,,fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" map the arrow keys to be based on display lines, not physical lines
noremap <Down> gj
noremap <Up> gk

" flip single lines
nmap <C-k> [e
nmap <C-j> ]e

" flip multiple lines
vmap <C-S-k> [egv
vmap <C-S-j> ]egv

" size all splits equally
nnoremap <silent> ≠ :wincmd =<cr>

" remove trailing whitespaces
nnoremap ,,fws :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>:update<CR>

" fix indentation to spaces
nnoremap ,,fi ggVG>gv<<esc>

" toggle search highlighting
nnoremap ,hs :set hlsearch! hlsearch?<CR>

" find functions
nnoremap <C-o> :CtrlPFunky<Cr>

" show hidden files
let g:ctrlp_show_hidden = 1

" clean up tab display
set showtabline=0

" select entire file
nnoremap ,,a ggVG

" change cursor to underscore on visual mode or insert mode.
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

" Use markdown instead of wiki lang
let g:vimwiki_list = [{'path': '$HOME/Dropbox/wiki', 'syntax': 'markdown'}]
let g:vimwiki_table_mappings = 0
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'javascript', 'php', 'ruby', 'shell=sh', 'js=javascript', 'c', 'vim']
:nnoremap ,dp :VimwikiDiaryPrevDay<CR>
:nnoremap ,dn :VimwikiDiaryNextDay<CR>

" ag is much faster at finding files than ctrlp defaults
if executable('ag')
  let g:ctrlp_user_command =
        \ 'ag %s --files-with-matches -g "" --ignore "*.min.js" --ignore "*.min.css" --ignore "node_modules" --ignore ".git"'
  let g:ctrlp_use_caching = 1
else
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$|node\_modules$'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}

" find syntax highlighting for the current text object
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" set background based on terminal active theme
if filereadable(expand("~/.vimrc_background"))
  set t_Co=256
  source ~/.vimrc_background
endif

" vue help
autocmd FileType vue :syntax sync fromstart
noremap <F9> <Esc>:syntax sync fromstart<CR>

" vimrc refresh automatically
augroup myvimrc
  au!
  au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc,.vimrc_background so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" my preferred statusline -- just need the file
set statusline=%t

" vimrc refresh
:nnoremap ,,r :so $MYVIMRC<CR>
