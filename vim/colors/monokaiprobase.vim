let g:colors.cterm.cursor    = 'NONE'
let g:colors.cterm.bg        = 'NONE'
let g:colors.cterm.fg        = '15'
let g:colors.cterm.offwhite  = '14'
let g:colors.cterm.gray1     = '0'
let g:colors.cterm.gray2     = '7'
let g:colors.cterm.gray3     = '8'
let g:colors.cterm.red       = '1'
let g:colors.cterm.green     = '2'
let g:colors.cterm.blue      = '4'
let g:colors.cterm.yellow    = '5'
let g:colors.cterm.green     = '2'
let g:colors.cterm.cyan      = '5'
let g:colors.cterm.purple      = '5'

let g:terminal_color_0  = g:colors.gui.bg
let g:terminal_color_1  = g:colors.gui.red
let g:terminal_color_2  = g:colors.gui.green
let g:terminal_color_3  = g:colors.gui.yellow
let g:terminal_color_4  = g:colors.gui.blue
let g:terminal_color_5  = g:colors.gui.purple
let g:terminal_color_6  = g:colors.gui.cyan
let g:terminal_color_7  = g:colors.gui.offwhite
let g:terminal_color_8  = g:colors.gui.gray3
let g:terminal_color_9  = g:colors.gui.red
let g:terminal_color_10 = g:colors.gui.green
let g:terminal_color_11 = g:colors.gui.blue
let g:terminal_color_12 = g:colors.gui.purple
let g:terminal_color_13 = g:colors.gui.cyan
let g:terminal_color_14 = g:colors.gui.fg
let g:terminal_color_15 = g:colors.gui.gray4

function! g:HL(group, guifg, ctermfg, guibg, ctermbg, attr)
  let l:attr = a:attr

  if !empty(a:ctermfg)
    exec 'hi ' . a:group . ' guifg=' . a:guifg . ' ctermfg=' . a:ctermfg
  endif

  if !empty(a:ctermbg)
    exec 'hi ' . a:group . ' guibg=' . a:guibg . ' ctermbg=' . a:ctermbg
  endif

  if !empty(a:attr)
    exec 'hi ' . a:group . ' gui=' . l:attr . ' cterm=' . l:attr
  endif
endfun

" Vim Editor
call g:HL('Cursor', '', '', g:colors.gui.cursor, g:colors.cterm.cursor, '')
call g:HL('matFg', '', '', g:colors.gui.fg, g:colors.cterm.fg, '')
call g:HL('matBg', '', '', g:colors.gui.bg, g:colors.cterm.bg, '')
call g:HL('matGray1', '', '', g:colors.gui.gray1, g:colors.cterm.gray1, '')
call g:HL('matGray2', '', '', g:colors.gui.gray2, g:colors.cterm.gray2, '')
call g:HL('matGray3', '', '', g:colors.gui.gray3, g:colors.cterm.gray3, '')

call g:HL('DiffAdd', g:colors.gui.green, g:colors.cterm.green, g:colors.gui.gray1, g:colors.cterm.gray1, '')
call g:HL('DiffChange', g:colors.gui.purple, g:colors.cterm.purple, g:colors.gui.gray1, g:colors.cterm.gray1, '')
call g:HL('DiffDelete', g:colors.gui.red, g:colors.cterm.red, g:colors.gui.gray1, g:colors.cterm.gray1, '')
call g:HL('DiffText', g:colors.gui.blue, g:colors.cterm.blue, g:colors.gui.gray1, g:colors.cterm.gray1, '')
call g:HL('Directory', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('ErrorMsg', g:colors.gui.red, g:colors.cterm.red, 'NONE', 'NONE', '')
call g:HL('FoldColumn', g:colors.gui.red, g:colors.cterm.red, g:colors.gui.gray1, g:colors.cterm.gray1, '')
call g:HL('Folded', g:colors.gui.red, g:colors.cterm.red, g:colors.gui.gray1, g:colors.cterm.gray1, '')
call g:HL('IncSearch', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('LineNr', g:colors.gui.gray3, g:colors.cterm.gray3, '', '', '')
call g:HL('ModeMsg', g:colors.gui.green, g:colors.cterm.green, '', '', 'bold')
call g:HL('MoreMsg', g:colors.gui.green, g:colors.cterm.green, '', '', 'bold')
call g:HL('NonText', g:colors.gui.gray3, g:colors.cterm.gray3, '', '', '')
call g:HL('Normal', g:colors.gui.fg, g:colors.cterm.fg, g:colors.gui.bg, 'NONE', '')
call g:HL('Pmenu', g:colors.gui.fg, g:colors.cterm.fg, g:colors.gui.inverse, g:colors.cterm.gray3, '')
call g:HL('PmenuSbar', '', '', g:colors.gui.blue, g:colors.cterm.blue, '')
call g:HL('PmenuSel', g:colors.gui.fg, g:colors.cterm.fg, g:colors.gui.gray2, g:colors.cterm.gray2, '')
call g:HL('PmenuThumb', '', '', g:colors.gui.red, g:colors.cterm.red, '')
call g:HL('Question', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('Search', '', '', g:colors.gui.purple, g:colors.cterm.purple, '')
call g:HL('SignColumn', '', '', 'NONE', 'NONE', 'none')
call g:HL('SpecialKey', g:colors.gui.gray3, g:colors.cterm.gray3, '', '', '')
call g:HL('SpellBad', g:colors.gui.red, g:colors.cterm.red, g:colors.gui.gray1, g:colors.cterm.gray1, 'undercurl')
call g:HL('SpellCap', g:colors.gui.blue, g:colors.cterm.blue, '', '', 'undercurl')
call g:HL('StatusLine', g:colors.gui.gray1, g:colors.cterm.gray1, g:colors.gui.gray3, g:colors.cterm.gray3, 'none')
call g:HL('StatusLineNC', g:colors.gui.gray2, g:colors.cterm.gray1, g:colors.gui.gray4, g:colors.cterm.bg, 'none')
call g:HL('TabLine', g:colors.gui.gray3, g:colors.cterm.gray3, g:colors.gui.gray1, g:colors.cterm.gray1, '')
call g:HL('TabLineFill', '', '', g:colors.gui.gray1, g:colors.cterm.gray1, 'NONE')
call g:HL('TabLineSel', g:colors.gui.red, g:colors.cterm.red, g:colors.gui.gray3, g:colors.cterm.gray3, 'NONE')
call g:HL('Title', g:colors.gui.green, g:colors.cterm.green, '', '', 'none')
call g:HL('VertSplit', g:colors.gui.gray3, g:colors.cterm.gray3, 'NONE', 'NONE', 'NONE')
call g:HL('Visual', '', '', g:colors.gui.offwhite, g:colors.cterm.offwhite, '')
call g:HL('WarningMsg', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('WildMenu', g:colors.gui.fg, g:colors.cterm.fg, g:colors.gui.red, g:colors.cterm.red, '')
call g:HL('Noise', g:colors.gui.gray1, g:colors.cterm.gray1, '', '', '')

" Standard Syntax
call g:HL('Comment', g:colors.gui.gray3, g:colors.cterm.gray3, '', '', 'italic')
call g:HL('Constant', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('String', g:colors.gui.yellow, g:colors.cterm.yellow, '', '', '')
call g:HL('Character', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('Identifier', g:colors.gui.green, g:colors.cterm.green, '', '', 'none')
call g:HL('Keyword', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('Statement', g:colors.gui.purple, g:colors.cterm.purple, '', '', 'none')
call g:HL('Operator', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('PreProc', g:colors.gui.red, g:colors.cterm.red, '', '', 'italic')
call g:HL('Include', g:colors.gui.red, g:colors.cterm.red, '', '', 'italic')
call g:HL('From', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('Define', g:colors.gui.purple, g:colors.cterm.purple, '', '', 'none')
call g:HL('Macro', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('Delimiter', g:colors.gui.fg, g:colors.cterm.fg, '', '', '')
call g:HL('Type', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', 'italic')
call g:HL('Structure', g:colors.gui.fg, g:colors.cterm.fg, '', '', '')
call g:HL('Special', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('Underlined', g:colors.gui.fg, g:colors.cterm.fg, '', '', 'none')
call g:HL('Error', g:colors.gui.red, g:colors.cterm.red, 'NONE', 'NONE', 'bold')
call g:HL('Todo', g:colors.gui.fg, g:colors.cterm.red, g:colors.gui.gray1, g:colors.cterm.gray1, 'bold')
call g:HL('ExtraWhitespace', '', '', g:colors.gui.red, g:colors.cterm.red, '')

" html
call g:HL('htmlTag', g:colors.gui.gray1, g:colors.cterm.gray1, '', '', 'none')
call g:HL('htmlTagName', g:colors.gui.red, g:colors.cterm.red, '', '', 'none')
call g:HL('htmlSpecialTagName', g:colors.gui.red, g:colors.cterm.red, '', '', 'none')
call g:HL('htmlArg', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', 'none')
call g:HL('htmlEndTag', g:colors.gui.gray1, g:colors.cterm.gray1, '', '', 'none')

" xml
call g:HL('xmlTag', g:colors.gui.fg, g:colors.cterm.fg, '', '', 'none')
call g:HL('xmlTagName', g:colors.gui.red, g:colors.cterm.red, '', '', 'none')
call g:HL('xmlAttrib', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', 'none')
call g:HL('xmlEndTag', g:colors.gui.red, g:colors.cterm.red, '', '', 'none')

" php
call g:HL('phpUseClass', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', 'none')
call g:HL('phpParent', g:colors.gui.gray1, g:colors.cterm.gray1, '', '', 'none')
call g:HL('phpIdentifier', g:colors.gui.fg, g:colors.cterm.fg, '', '', 'none')
call g:HL('phpFunction', g:colors.gui.green, g:colors.cterm.green, '', '', 'none')
call g:HL('phpMethod', g:colors.gui.green, g:colors.cterm.green, '', '', 'none')
call g:HL('phpKeyword', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', 'none')
call g:HL('phpType', g:colors.gui.red, g:colors.cterm.red, '', '', 'none')
" call g:HL('phpRegion', g:colors.gui.green, g:colors.cterm.green, '', '', 'none')
call g:HL('phpStaticClasses', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', 'none')
call g:HL('phpClass', g:colors.gui.red, g:colors.cterm.red, '', '', 'none')
call g:HL('phpReturn', g:colors.gui.red, g:colors.cterm.red, '', '', 'none')
call g:HL('phpThis', g:colors.gui.gray1, g:colors.cterm.gray1, '', '', 'none')
call g:HL('phpVarSelector', g:colors.gui.gray1, g:colors.cterm.gray1, '', '', 'none')

" javascript
call g:HL('jsExportDefault', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('jsExportDefault', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('jsVariableDef', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('jsObjectStringKey', g:colors.gui.gray1, g:colors.cterm.gray1, '', '', '')
call g:HL('jsReturn', g:colors.gui.red, g:colors.cterm.red, '', '', 'none')
call g:HL('jsFuncArgs', g:colors.gui.blue, g:colors.cterm.blue, '', '', 'none')
call g:HL('jsNull', g:colors.gui.purple, g:colors.cterm.purple, '', '', 'none')
call g:HL('jsThis', g:colors.gui.gray1, g:colors.cterm.gray1, '', '', 'none')
call g:HL('jsConditional', g:colors.gui.red, g:colors.cterm.red, '', '', 'none')

" CSS
call g:HL('cssAttrComma', g:colors.gui.fg, g:colors.cterm.fg, '', '', '')
call g:HL('cssBraces', g:colors.gui.fg, g:colors.cterm.fg, '', '', '')
call g:HL('cssClassName', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('cssIdentifier', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('cssProp', g:colors.gui.fg, g:colors.cterm.fg, '', '', '')
call g:HL('cssAttrRegion', g:colors.gui.fg, g:colors.cterm.fg, '', '', 'none')
call g:HL('cssTagName', g:colors.gui.fg, g:colors.cterm.fg, '', '', 'none')
call g:HL('cssDefinition', g:colors.gui.fg, g:colors.cterm.fg, '', '', 'none')
call g:HL('cssStyle', g:colors.gui.fg, g:colors.cterm.fg, '', '', 'none')
call g:HL('cssValueLength', g:colors.gui.purple, g:colors.cterm.purple, '', '', 'none')
call g:HL('cssUnitDecorators', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('cssSelectorOp', g:colors.gui.fg, g:colors.cterm.fg, '', '', '')
call g:HL('cssSelectorOp2', g:colors.gui.fg, g:colors.cterm.fg, '', '', '')

" SCSS
call g:HL('scssVariable', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('scssAttribute', g:colors.gui.red, g:colors.cterm.red, '', '', '')

" Other stuff
call g:HL('CursorLineNR', g:colors.gui.gray1, g:colors.cterm.gray1, g:colors.gui.inverse, g:colors.cterm.gray3, 'none')
call g:HL('CursorLine', '', '', 'NONE', 'NONE', 'none')
call g:HL('CtrlPMatch', '', '', '', '', 'bold')
hi MatchParen cterm=bold ctermbg=NONE guibg=NONE gui=bold,underline guibg=NONE guifg=NONE

let g:fzf_colors = {
      \ 'fg':      ['fg', 'Pmenu'],
      \ 'bg':      ['bg', 'Pmenu'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'PmenuSel'],
      \ 'bg+':     ['bg', 'PmenuSel'],
      \ 'hl+':     ['fg', 'Special'],
      \ 'info':    ['fg', 'Number'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Error'],
      \ 'pointer': ['fg', 'Special'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }
