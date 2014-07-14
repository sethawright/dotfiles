set t_Co=256
set guioptions-=T
set guioptions-=R
set guioptions-=r
set guioptions-=L
set guifont=Nitti\ Basic\ Light:h16
set linespace=8
set nonumber
set wrap linebreak nolist
set guicursor=a:ver25-Cursor
set background=light
colorscheme pencil

:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
:hi NonText guifg=bg

function! FocusOn()
    set cursorline
    colorscheme pencil-focus
    :hi CursorLine cterm=NONE ctermbg=NONE ctermfg=white guibg=NONE guifg=#424242
    :hi NonText guifg=bg
    set guifont=Nitti\ Basic\ Light:h22

    noremap <buffer> <silent> k gkzz
    noremap <buffer> <silent> j gjzz
endfunction

function! FocusOff()
    set nocursorline
    colorscheme pencil
    :hi NonText guifg=bg
    set guifont=Nitti\ Basic\ Light:h16

    noremap <buffer> <silent> k gk
    noremap <buffer> <silent> j gj
endfunction

:nnoremap <leader>fo :call FocusOn()<Cr>
:nnoremap <leader>fO :call FocusOff()<Cr>
