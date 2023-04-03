highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'monokaiprospectrum'
let g:colors = {'gui' : {} , 'cterm' : {}}

let g:colors.gui.fg          = '#F7F1FF'
let g:colors.gui.bg          = '#222222'
let g:colors.gui.cursor      = '#F7F1FF'
let g:colors.gui.gray4       = '#191919' " status line inactive (vscode sidebar bg)
let g:colors.gui.gray3       = '#2D2C2D' " comment (vscode active line)
let g:colors.gui.gray2       = '#434144' " pmenu fg (vscode visual selection)
let g:colors.gui.gray1       = '#525053' " pmenu fg (vscode comment)
let g:colors.gui.offwhite    = '#2D2C2D' " visual selection (vscode active line)
let g:colors.gui.inverse     = '#171717'

let g:colors.gui.red         = '#FC628D'
let g:colors.gui.green       = '#7BD78F'
let g:colors.gui.yellow      = '#FDE366'
let g:colors.gui.blue        = '#FE9253'
let g:colors.gui.purple      = '#938CE3'
let g:colors.gui.cyan        = '#58D4E6'

source ~/.vim/colors/monokaiprobase.vim
