" vundle start
set nocp
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/bin/fzf

" load plugins
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'mileszs/ack.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'vim-ctrlspace/vim-ctrlspace'
Plugin 'vimwiki/vimwiki'

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

Plugin 'christoomey/vim-tmux-navigator'
Plugin 'junegunn/goyo.vim'
" Plugin 'itchyny/lightline.vim'

Plugin 'posva/vim-vue'
Plugin 'pangloss/vim-javascript'
Plugin 'jwalton512/vim-blade'
Plugin 'StanAngeloff/php.vim'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'burner/vim-svelte'

Plugin 'cormacrelf/vim-colors-github'
Plugin 'arcticicestudio/nord-vim'
Plugin 'dracula/vim'
Plugin 'chriskempson/base16-vim'
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
" set number
" set relativenumber
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
set number
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

" previous buffer
nnoremap <C-n> <C-^>

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

let g:fzf_action = {
  \ 'ctrl-d': 'bdelete',
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'down': '10' }
let g:fzf_buffers_jump = 1

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=1 showmode ruler

" clean up tab display
set showtabline=0
set noshowmode

" select entire file
nnoremap ,,a ggVG

" custom mappings for tmux navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

" Use markdown instead of wiki lang
let g:vimwiki_list = [{'path': '$HOME/Documents/wiki', 'syntax': 'markdown', 'ext': '.txt'}]
let g:vimwiki_table_mappings = 0
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'javascript', 'php', 'ruby', 'shell=sh', 'js=javascript', 'c', 'vim']
:nnoremap ,dp :VimwikiDiaryPrevDay<CR>
:nnoremap ,dn :VimwikiDiaryNextDay<CR>

" find syntax highlighting for the current text object
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

if has('nvim')
  let g:CtrlSpaceDefaultMappingKey = "<C-space> "
end

nnoremap ,js :%!python -m json.tool<CR>

" vue help
autocmd FileType vue syntax sync fromstart

" vimrc refresh automatically
augroup myvimrc
  au!
  au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc,.vimrc_background so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

au BufNewFile,BufRead *.ejs set filetype=html

" my preferred statusline -- just need the file
set statusline=%{expand('%:~:.')}

" some basic snippets i use
runtime snippets.vim

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

let g:goyo_width = '50%'

" vimrc refresh
:nnoremap ,,r :so $MYVIMRC<CR>

" set background based on terminal active theme
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  set termguicolors
  source ~/.vimrc_background
  if g:colors_name != 'dracula' && g:colors_name != 'nord'
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
