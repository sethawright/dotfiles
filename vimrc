" vundle start
set nocp
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/bin/fzf

" load plugins
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'scrooloose/nerdtree'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'chriskempson/base16-vim'
Plugin 'arcticicestudio/nord-vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'mileszs/ack.vim'
Plugin 'vimwiki/vimwiki'
Plugin 'vim-ctrlspace/vim-ctrlspace'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tomtom/tcomment_vim'
Plugin 'posva/vim-vue'
Plugin 'pangloss/vim-javascript'
Plugin 'jwalton512/vim-blade'
Plugin 'StanAngeloff/php.vim'
" Plugin 'itchyny/lightline.vim'
Plugin 'mxw/vim-jsx'
Plugin 'vimlab/split-term.vim'
call vundle#end()

filetype plugin indent on
syntax on

" leader to comma
let mapleader=","
set mouse=a

set timeoutlen=300
set ttimeoutlen=0

" various config
set backspace=indent,eol,start
set breakindent
set autoindent
set ruler
set hidden
set nonumber
set norelativenumber
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

nnoremap / /\v
vnoremap / /\v

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
noremap ,w2 :set tabstop=2 shiftwidth=2<CR>
noremap ,w4 :set tabstop=4 shiftwidth=4<CR>

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
nnoremap <C-n> :enew<CR>
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
nnoremap ,,n :NERDTreeFind<CR>
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'
let NERDTreeShowHidden = 1

" ack vim settings
let g:ackhighlight = 1

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

" clear the previous search
nnoremap ,cs :let @/ = ""<CR>

" find files
nnoremap <C-p> :Files<Cr>

" ctags
nnoremap <C-o> :BTags<Cr>
nnoremap ø :Tags<Cr>

nnoremap <C-i> :Buffers<Cr>

" buffers
nnoremap <C-u> :Lines<Cr>

let g:fzf_action = {
  \ 'ctrl-d': 'bdelete',
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'down': '10' }
let g:fzf_buffers_jump = 1
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'CursorLineNr'],
  \ 'hl':      ['fg', 'DiffText'],
  \ 'fg+':     ['fg', 'Normal', 'DiffText', 'Bold'],
  \ 'bg+':     ['bg', 'StatusLine', 'StatusLine'],
  \ 'hl+':     ['fg', 'DiffDelete'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'DiffDelete'],
  \ 'pointer': ['fg', 'Keyword'],
  \ 'marker':  ['fg', 'TabLine'],
  \ 'spinner': ['fg', 'String'],
  \ 'header':  ['fg', 'Tabline'] }

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

" find syntax highlighting for the current text object
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" set background based on terminal active theme
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
  hi LineNr ctermbg=NONE guibg=NONE
  hi VertSplit ctermbg=NONE guibg=NONE
endif

" vue help
autocmd FileType vue :syntax sync fromstart
noremap <F9> <Esc>:syntax sync fromstart<CR>

" vimrc refresh automatically
augroup myvimrc
  au!
  au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc,.vimrc_background so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

au BufNewFile,BufRead *.ejs set filetype=html

" my preferred statusline -- just need the file
set statusline=%t

" some basic snippets i use
runtime snippets.vim

" get filename, file path
nmap ,cs :let @*=expand("%")<CR>
nmap ,cl :let @*=expand("%:p")<CR>

" vimrc refresh
:nnoremap ,,r :so $MYVIMRC<CR>
