highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'monokaipromachine'
let g:colors = {'gui' : {} , 'cterm' : {}}

let g:colors.gui.fg          = '#F2FFFC'
let g:colors.gui.bg          = '#273136'
let g:colors.gui.cursor      = '#F2FFFC'
let g:colors.gui.gray4       = '#1D2528' " status line inactive (vscode sidebar bg)
let g:colors.gui.gray3       = '#313B40' " comment (vscode active line)
let g:colors.gui.gray2       = '#3C474B' " pmenu fg (vscode visual selection)
let g:colors.gui.gray1       = '#545F62' " pmenu fg (vscode comment)
let g:colors.gui.offwhite    = '#313B40' " visual selection (vscode active line)
let g:colors.gui.inverse     = '#171717'

let g:colors.gui.red         = '#FF6D7E'
let g:colors.gui.green       = '#A9DB76'
let g:colors.gui.yellow      = '#FFEB72'
let g:colors.gui.blue        = '#FFB170'
let g:colors.gui.purple      = '#BAA2F8'
let g:colors.gui.cyan        = '#7BD6F1'

source ~/.vim/colors/monokaiprobase.vim
