" vundle start
set nocp
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/bin/fzf

" load plugins
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'vim-ctrlspace/vim-ctrlspace'

Plugin 'w0rp/ale'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'mattn/emmet-vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'kassio/neoterm'

Plugin 'christoomey/vim-tmux-navigator'
Plugin 'junegunn/goyo.vim'

Plugin 'posva/vim-vue'
Plugin 'pangloss/vim-javascript'
Plugin 'jwalton512/vim-blade'
Plugin 'StanAngeloff/php.vim'
Plugin 'cakebaker/scss-syntax.vim'

Plugin 'dracula/vim'
Plugin 'chriskempson/base16-vim'
call vundle#end()

filetype plugin indent on
syntax enable

" leader to comma
let mapleader=","
set mouse=a

if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

" various config
set backspace=indent,eol,start
set breakindent
set autoindent
set autoread
set hidden
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
noremap ,,w2 :set tabstop=2 shiftwidth=2<CR>
noremap ,,w4 :set tabstop=4 shiftwidth=4<CR>

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

" my preferred statusline -- just need the file
set statusline=%{expand('%:~:.')}

" vertical resize
nnoremap = :res +10<CR>
nnoremap - :res -10<CR>

" horizontal resize
nnoremap + :vertical res +10<CR>
nnoremap _ :vertical res -10<CR>

" text wrapping toggles
nnoremap <silent> ,,tw :set invwrap<CR>:set wrap?<CR>:set linebreak<CR>

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

" toggle search highlighting
nnoremap ,hs :set hlsearch! hlsearch?<CR>

" clear the previous search
nnoremap ,cs :let @/ = ""<CR>

" find files
nnoremap <C-p> :Files<Cr>

" ctags
nnoremap <C-o> :BTags<Cr>
nnoremap ø :Tags<Cr>

" select entire file
nnoremap ,,a ggVG

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
:nnoremap ,,r :so $MYVIMRC<CR>

" pretty format json
nnoremap ,js :%!python -m json.tool<CR>

" NERDTree
let NERDTreeMinimalUI = 1
let g:NERDTreeQuitOnOpen = 1
nnoremap ,n :NERDTreeToggle<CR>
nnoremap ,,n :NERDTreeFind<CR>
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'
let NERDTreeShowHidden = 1

" FZF
let g:fzf_action = {
  \ 'ctrl-d': 'bdelete',
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '10' }
let g:fzf_buffers_jump = 1
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=1 showmode noruler
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

" Tmux Navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

" Ctrl-Space
if has('nvim')
  let g:CtrlSpaceDefaultMappingKey = "<C-space> "
end

" some basic snippets i use
runtime snippets.vim

" ALE customizations
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_set_highlights = 0
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'html': ['prettier'],
\   'javascript': ['eslint'],
\   'vue': ['eslint'],
\   'css': ['prettier']
\}

" Goyo.vim
let g:goyo_width = '50%'

" Markdown no folding
let g:vim_markdown_folding_disabled = 1

" Terminal customizations
let g:neoterm_autoinsert = 1
let g:neoterm_default_mod = 'botright'
nnoremap « :vert Tnew<CR>
nnoremap ‘ :botright Tnew<CR>
tnoremap « <C-\><C-n>:vert Tnew<CR>
tnoremap ‘ <C-\><C-n>:belowright Tnew<CR>

" set background based on terminal active theme
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  set termguicolors
  source ~/.vimrc_background
  hi MatchParen term=bold,underline cterm=bold,underline gui=bold,underline guibg=NONE ctermbg=NONE
  if g:colors_name != 'dracula'
    hi LineNr ctermbg=NONE guibg=NONE
    hi link ALEWarningSign gitGutterChange
    hi link ALEErrorSign gitGutterDelete
    hi SignColumn ctermbg=NONE guibg=NONE
    hi gitGutterAdd ctermbg=NONE guibg=NONE
    hi gitGutterDelete ctermbg=NONE guibg=NONE
    hi gitGutterChange ctermbg=NONE guibg=NONE
    hi gitGutterChangeDelete ctermbg=NONE guibg=NONE
    hi VertSplit ctermbg=NONE guibg=NONE
  end
endif
