highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'materitermlighter'
let g:colors = {'gui' : {} , 'cterm' : {}}

let g:colors.gui.cursor      = '#ffcc00'
let g:colors.gui.fg          = '#90A4AE'
let g:colors.gui.bg          = '#ffffff'
let g:colors.gui.offwhite    = '#e5e9ea'
let g:colors.gui.inverse     = '#eff1f2'
let g:colors.gui.gray4       = '#eff1f2'
let g:colors.gui.gray3       = '#b0bec5'
let g:colors.gui.gray2       = '#c4cfd4'
let g:colors.gui.gray1       = '#7e939e'

source ~/.vim/colors/materitermbase.vim
