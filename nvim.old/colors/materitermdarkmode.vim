highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'materitermdarkmode'
let g:colors = {'gui' : {} , 'cterm' : {}}

let g:colors.gui.cursor      = '#ffcc00'
let g:colors.gui.fg          = '#eeffff'
let g:colors.gui.bg          = '#212121'
let g:colors.gui.offwhite    = '#36383d'
let g:colors.gui.inverse     = '#171717'
let g:colors.gui.gray4       = '#333333'
let g:colors.gui.gray3       = '#444444'
let g:colors.gui.gray2       = '#666666'
let g:colors.gui.gray1       = '#888888'

source ~/.config/nvim/colors/materitermbase.vim
