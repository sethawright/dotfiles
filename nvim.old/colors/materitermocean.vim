highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'materitermocean'
let g:colors = {'gui' : {} , 'cterm' : {}}

let g:colors.gui.cursor      = '#ffcc00'
let g:colors.gui.fg          = '#8f9da2'
let g:colors.gui.bg          = '#0f111a'
let g:colors.gui.offwhite    = '#3f4464'
let g:colors.gui.inverse     = '#181c2a'
let g:colors.gui.gray4       = '#181c2a'
let g:colors.gui.gray3       = '#22263a'
let g:colors.gui.gray2       = '#353b5a'
let g:colors.gui.gray1       = '#464b5d'

source ~/.config/nvim/colors/materitermbase.vim
