" Setup for IA Writer Mode
set t_Co=256
set guioptions-=T
set guioptions-=R
set guioptions-=r
set guioptions-=L
set linespace=8
set guifont=Source\ Code\ Pro\ for\ Powerline:h13

" set guifont=Nitti\ Basic\ Light:h18
" set nonumber
" set wrap linebreak nolist
" set background=light
" colorscheme pencil
"
" :nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
" :hi NonText guifg=bg
"
" function! FocusOn()
"     set cursorline
"     colorscheme pencil-focus
"     :hi CursorLine cterm=NONE ctermbg=NONE ctermfg=white guibg=NONE guifg=#424242
"     :hi NonText guifg=bg
"     set guifont=Nitti\ Basic\ Light:h22
"
"     noremap <buffer> <silent> k gkzz
"     noremap <buffer> <silent> j gjzz
" endfunction
"
" function! FocusOff()
"     set nocursorline
"     colorscheme pencil
"     :hi NonText guifg=bg
"     set guifont=Nitti\ Basic\ Light:h18
"
"     noremap <buffer> <silent> k gk
"     noremap <buffer> <silent> j gj
" endfunction
"
" :nnoremap <leader>fo :call FocusOn()<Cr>
" :nnoremap <leader>fO :call FocusOff()<Cr>
