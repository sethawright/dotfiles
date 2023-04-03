highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'monokaiprooctagon'
let g:colors = {'gui' : {} , 'cterm' : {}}

let g:colors.gui.fg          = '#EAF2F1'
let g:colors.gui.bg          = '#282A3A'
let g:colors.gui.cursor      = '#EAF2F1'
let g:colors.gui.gray4       = '#1E1F2B' " status line inactive (vscode sidebar bg)
let g:colors.gui.gray3       = '#323443' " comment (vscode active line)
let g:colors.gui.gray2       = '#3D404D' " pmenu fg (vscode visual selection)
let g:colors.gui.gray1       = '#535763' " pmenu fg (vscode comment)
let g:colors.gui.offwhite    = '#323443' " visual selection (vscode active line)
let g:colors.gui.inverse     = '#171717'

let g:colors.gui.red         = '#FF657A'
let g:colors.gui.green       = '#BAD561'
let g:colors.gui.yellow      = '#FFD66D'
let g:colors.gui.blue        = '#FF9A5E'
let g:colors.gui.purple      = '#C39BC9'
let g:colors.gui.cyan        = '#9CD1BB'

source ~/.vim/colors/monokaiprobase.vim
