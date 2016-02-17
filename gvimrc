" Setup for IA Writer Mode
set t_Co=256
set guioptions-=T
set guioptions-=R
set guioptions-=r
set guioptions-=L
set linespace=8
set guifont=Source\ Code\ Pro\ for\ Powerline:h12
set norelativenumber
set nonumber
set laststatus=0
:call SetSethEnv('base16-google', 'light')

:nnoremap <leader>wr :call DistractionFreeWriting()<Cr>
:nnoremap <leader>df :call DistractionFreeFS()<Cr>

let g:fullscreen_colorscheme = "iawriter"
let g:fullscreen_font = "Nitti\ Basic\ Light:h27"
let g:normal_colorscheme = "base16-ocean"
let g:normal_font="Source\ Code\ Pro\ for\ Powerline:h12"

function! DistractionFreeFS()
    colorscheme iawriter
    set background=light
    set gfn=Nitti\ Basic\ Light:h22                " font to use
    set lines=40 columns=100           " size of the editable area
    set fuoptions=background:#00f5f6f6 " macvim specific setting for editor's background color 
    set wrap linebreak nolist
    set guioptions-=r                  " remove right scrollbar
    set laststatus=0                   " don't show status line
    set linespace=5
    set noruler                        " don't show ruler
    set fullscreen                     " go to fullscreen editing mode
    set display+=lastline " show incomplete paragraphs even when they don't fit on screen (avoid @'s)
    set linebreak                      " break the lines on words
endfunction

function! DistractionFreeWriting()
    colorscheme iawriter
    set background=light
    set gfn=Nitti\ Basic\ Light:h16                " font to use
    set linespace=5
    set wrap linebreak nolist
    set display+=lastline " show incomplete paragraphs even when they don't fit on screen (avoid @'s)
    set lines=40 columns=100           " size of the editable area
    set fuoptions=background:#00f5f6f6 " macvim specific setting for editor's background color 
    set guioptions-=r                  " remove right scrollbar
    set laststatus=0                   " don't show status line
    set noruler                        " don't show ruler
    set linebreak                      " break the lines on words
endfunction
