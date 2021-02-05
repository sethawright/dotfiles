" vundle start
set nocp
filetype off
set rtp+=/usr/local/bin/fzf

" load plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-ctrlspace/vim-ctrlspace'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tomtom/tcomment_vim'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeFind', 'NERDTreeToggle'] }
Plug 'tpope/vim-fugitive'
Plug 'mattn/emmet-vim'
Plug 'christoomey/vim-tmux-navigator'

Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'posva/vim-vue', { 'for': 'vue' }
Plug 'dag/vim-fish', { 'for': ['fish'] }
Plug 'pangloss/vim-javascript', { 'for': ['vue', 'javascript', 'json'] }
Plug 'jwalton512/vim-blade', { 'for': ['php', 'blade'] }
Plug 'StanAngeloff/php.vim', { 'for': ['php'] }
Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss', 'vue'] }
Plug 'MaxMEllon/vim-jsx-pretty'

" Plug 'cormacrelf/vim-colors-github'
" Plug 'morhetz/gruvbox'
" Plug 'dracula/vim'
" Plug 'chriskempson/base16-vim'
call plug#end()

filetype plugin indent on
syntax enable

" leader to space
let g:mapleader="\<space>"
set mouse=

if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

if has('nvim')
  let g:CtrlSpaceDefaultMappingKey = "<C-space> "
endif

" various config
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
vmap <C-S-k> [egv
vmap <C-S-j> ]egv

" size all splits equally
nnoremap <silent> ≠ :wincmd =<cr>

" toggle search highlighting
nnoremap <silent> ,hs :set hlsearch! hlsearch?<CR>

" clear the previous search
nnoremap <silent> ,cs :let @/ = ""<CR>

" gutentags
" let g:gutentags_file_list_command = 'rg --files --hidden --follow --glob "!{node_modules/*,vendor/*,.git/*}"'

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

" NERDTree
let NERDTreeMinimalUI = 1
let g:NERDTreeQuitOnOpen = 1
nnoremap <silent> ,n :NERDTreeToggle<CR>
nnoremap <silent> ,,n :NERDTreeFind<CR>
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'
let NERDTreeShowHidden = 1

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

nnoremap <silent> <leader><space> :Files<cr>
nnoremap <silent> <leader>p :Files<cr>
nnoremap <silent> <leader>o :BTags<cr>
nnoremap <silent> <leader>; :BLines<cr>
nnoremap <silent> <leader>gl :Commits<cr>
nnoremap <silent> <leader>gh :BCommits<cr>
nnoremap <silent> <leader>? :History<cr>
nnoremap <silent> <leader>d :DelBuffers<cr>
nnoremap <leader>/ :Rg<space>

function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:format_buffer(b)
  let l:name = bufname(a:b)
  let l:name = empty(l:name) ? '[No Name]' : fnamemodify(l:name, ":p:~:.")
  let l:flag = a:b == bufnr('')  ? '%' :
          \ (a:b == bufnr('#') ? '#' : ' ')
  let l:modified = getbufvar(a:b, '&modified') ? ' [+]' : ''
  let l:readonly = getbufvar(a:b, '&modifiable') ? '' : ' [RO]'
  let l:extra = join(filter([l:modified, l:readonly], '!empty(v:val)'), '')
  return substitute(printf("[%s] %s\t%s\t%s", a:b, l:flag, l:name, l:extra), '^\s*\|\s*$', '', 'g')
endfunction

function! s:delete_buffers()
  let l:preview_window = get(g:, 'fzf_preview_window', &columns >= 120 ? 'right': '')
  let l:options = [
  \   '-m',
  \   '--tiebreak=index',
  \   '-d', '\t',
  \   '--prompt', 'Delete> '
  \ ]
  if len(l:preview_window)
    let l:options = extend(l:options, get(fzf#vim#with_preview(
          \   {"placeholder": "{2}"},
          \   l:preview_window
          \ ), 'options', []))
  endif

  return fzf#run(fzf#wrap({
  \ 'source':  map(
  \   filter(
  \     range(1, bufnr('$')),
  \     {_, nr -> buflisted(nr) && !getbufvar(nr, "&modified")}
  \   ),
  \   {_, nr -> s:format_buffer(nr)}
  \ ),
  \ 'sink*': {
  \   lines -> execute('bdelete ' . join(map(lines, {
  \     _, line -> substitute(split(line)[0], '^\[\|\]$', '', 'g')
  \   })), 'silent!')
  \ },
  \ 'options': l:options,
  \}))
endfunction

command! DelBuffers call s:delete_buffers()

" Trying not to use these anymore and save my left pinky
nnoremap <C-p> :Files<Cr>
nnoremap <C-o> :BTags<Cr>

" Tmux Navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

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

" Coc stuff
"" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
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

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" Or use `complete_info` if your vim support it, like:
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

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
  let g:gruvbox_italic=1
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

set statusline=%{expand('%:~:.')}
