highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'materitermpale'
let g:colors = {'gui' : {} , 'cterm' : {}}

let g:colors.gui.cursor      = '#ffcc00'
let g:colors.gui.fg          = '#eeffff'
let g:colors.gui.bg          = '#292d3e'
let g:colors.gui.offwhite    = '#353a52'
let g:colors.gui.inverse     = '#33384d'
let g:colors.gui.gray4       = '#33384d'
let g:colors.gui.gray3       = '#474e6c'
let g:colors.gui.gray2       = '#5b648b'
let g:colors.gui.gray1       = '#7e818b'

source ~/.config/nvim/colors/materitermbase.vim
