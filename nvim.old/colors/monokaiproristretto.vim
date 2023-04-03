highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'monokaiproristretto'
let g:colors = {'gui' : {} , 'cterm' : {}}

let g:colors.gui.fg          = '#FFF1F3'
let g:colors.gui.bg          = '#2C2525'
let g:colors.gui.cursor      = '#FFF1F3'
let g:colors.gui.gray4       = '#211C1C' " status line inactive (vscode sidebar bg)
let g:colors.gui.gray3       = '#372F2F' " comment (vscode active line)
let g:colors.gui.gray2       = '#423A3A' " pmenu fg (vscode visual selection)
let g:colors.gui.gray1       = '#5B5353' " pmenu fg (vscode comment)
let g:colors.gui.offwhite    = '#372F2F' " visual selection (vscode active line)
let g:colors.gui.inverse     = '#171717'

let g:colors.gui.red         = '#FE6983'
let g:colors.gui.green       = '#ADD978'
let g:colors.gui.yellow      = '#FACB6C'
let g:colors.gui.blue        = '#F38C70'
let g:colors.gui.purple      = '#A7ABEB'
let g:colors.gui.cyan        = '#84DACC'

source ~/.vim/colors/monokaiprobase.vim
