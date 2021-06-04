highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'monokaipro'
let g:colors = {'gui' : {} , 'cterm' : {}}

let g:colors.gui.fg          = '#FCFCFA'
let g:colors.gui.bg          = '#2D2A2E'
let g:colors.gui.cursor      = '#FCFCFA'
let g:colors.gui.gray4       = '#221F22' " status line inactive (vscode sidebar bg)
let g:colors.gui.gray3       = '#434144' " comment (vscode visual selection)
let g:colors.gui.gray2       = '#434144' " pmenu fg (vscode visual selection)
let g:colors.gui.gray1       = '#727072' " pmenu fg (vscode comment)
let g:colors.gui.offwhite    = '#383539' " visual selection (vscode active line)
let g:colors.gui.inverse     = '#171717'

let g:colors.gui.red         = '#FF6288'
let g:colors.gui.green       = '#A9DB76'
let g:colors.gui.yellow      = '#FFD666'
let g:colors.gui.blue        = '#FD9767'
let g:colors.gui.purple      = '#AA9FF2'
let g:colors.gui.cyan        = '#77DCE8'

source ~/.vim/colors/monokaiprobase.vim
