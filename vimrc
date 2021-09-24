set nocp
filetype off
set rtp+=/usr/local/bin/fzf

" load plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'mattn/emmet-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jesseleite/vim-noh'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'posva/vim-vue', { 'for': ['vue'] }
Plug 'dag/vim-fish', { 'for': ['fish'] }
Plug 'pangloss/vim-javascript', { 'for': ['javascript'] }
Plug 'jwalton512/vim-blade', { 'for': ['php', 'blade'] }
Plug 'StanAngeloff/php.vim', { 'for': ['php'] }
Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss'] }
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }
call plug#end()

filetype plugin indent on
syntax enable

" leader to space
let g:mapleader="\<space>"

" various config
set termguicolors
set backspace=indent,eol,start
set breakindent
set autoindent
set autoread
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set number
set smarttab
set noruler
set nocursorline
set display=lastline
set tabstop=2
set signcolumn=yes
set shiftwidth=2
set nowrap
set textwidth=0
set linebreak
set nolist
set expandtab
set noswapfile
set hlsearch
set incsearch
set ignorecase
set foldmethod=manual
set noshowmode
set showtabline=0

nnoremap / /\v
vnoremap / /\v

" quick saves and quits
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
tnoremap <leader>q <C-\><C-n>:q!<CR>
nnoremap ,w :w<CR>
nnoremap ,q :q<CR>
tnoremap ,q <C-\><C-n>:q!<CR>

" quickly toggle the terminal pane
nnoremap ,t :TtoggleAll<CR>
tnoremap ,t <C-\><C-n>:TtoggleAll<CR>

" tmux style moving between windows
nnoremap ç :tabnew<CR>
nnoremap ¬ :tabp<CR>
nnoremap ˙ :tabn<CR>
tnoremap ç <C-\><C-n>:tabnew<CR>
tnoremap ¬ <C-\><C-n>:tabp<CR>
tnoremap ˙ <C-\><C-n>:tabn<CR>
tnoremap <C-n> <C-\><C-n>

" quicker exiting terminal insert mode
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <C-h> <C-\><C-n><C-w>k
if has('nvim')
    autocmd BufEnter,BufNew term://* startinsert
endif

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

" preferred copying/pasting
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

" text wrapping toggles
nnoremap <silent> ,tw :set invwrap<CR>:set wrap?<CR>:set linebreak<CR>

" map the arrow keys to be based on display lines, not physical lines
noremap <Down> gj
noremap <Up> gk

" flip single lines
nmap <C-k> [e
nmap <C-j> ]e

" flip multiple lines
vnoremap <C-S-k> [egv
vnoremap <C-S-j> ]egv

" size all splits equally
nnoremap <silent> ≠ :wincmd =<cr>

" toggle search highlighting
nnoremap <silent> ,hs :set hlsearch! hlsearch?<CR>

" clear the previous search
nnoremap <silent> ,cs :let @/ = ""<CR>

" select entire file
nnoremap <silent> ,,a ggVG

" find syntax highlighting for the current text object
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" better vue syntax highlighting
autocmd FileType vue syntax sync fromstart

" vimrc refresh automatically
augroup myvimrc
  au!
  au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc,.vimrc_background so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" force vimrc refresh
nnoremap ,,r :so $MYVIMRC<CR>

" pretty format json
nnoremap ,js :%!python -m json.tool<CR>

" FZF
let g:fzf_action = {
  \ 'ctrl-d': 'bwipeout',
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-o': '!open' }
let g:fzf_layout = { 'down': '10' }
let g:fzf_buffers_jump = 1
let g:fzf_nvim_statusline = 0
let g:fzf_colors =
\ { 'fg':      ['fg', 'Pmenu'],
  \ 'bg':      ['bg', 'Pmenu'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=1 showmode noruler

nnoremap <leader>b :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>e :NvimTreeFindFile<CR>
nnoremap <silent> <leader><space> :Buffers<cr>
nnoremap <silent> <c-space> :Buffers<cr>
nnoremap <silent> <leader>p :Files<cr>
nnoremap <silent> <leader>o :BTags<cr>
nnoremap <silent> <leader>; :BLines<cr>
nnoremap <silent> <leader>f :GFiles?<cr>
nnoremap <silent> <leader>gl :Commits<cr>
nnoremap <silent> <leader>gh :BCommits<cr>
nnoremap <silent> <leader>gd :Gdiff HEAD<cr>
nnoremap <silent> <leader>? :History<cr>
nnoremap <leader>/ :Rg<space>

" Trying not to use these anymore and save my left pinky
nnoremap <C-p> :Files<Cr>
nnoremap <C-o> :BTags<Cr>

" Tmux Navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

" some basic snippets i use
runtime snippets.vim

" Goyo.vim
let g:goyo_width = '50%'

" Markdown no folding
let g:vim_markdown_folding_disabled = 1

" set background based on terminal active theme
if filereadable(expand("~/.vimrc_background"))
  set termguicolors
  source ~/.vimrc_background
endif
