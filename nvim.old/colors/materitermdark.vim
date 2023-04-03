highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'materitermdark'
let g:colors = {'gui' : {} , 'cterm' : {}}

let g:colors.gui.cursor      = '#ffcc00'
let g:colors.gui.fg          = '#eeffff'
let g:colors.gui.bg          = '#263238'
let g:colors.gui.offwhite    = '#2f3f47'
let g:colors.gui.inverse     = '#1E2832'
let g:colors.gui.gray4       = '#304047'
let g:colors.gui.gray3       = '#3b4d56'
let g:colors.gui.gray2       = '#506874'
let g:colors.gui.gray1       = '#72909e'

source ~/.config/nvim/colors/materitermbase.vim
