highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'minlight'
let g:colors = {'gui' : {} , 'cterm' : {}}

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
let g:colors.cterm.purple    = '5'

let g:colors.gui.cursor      = '#E7F3FF'
let g:colors.gui.fg          = '#000000'
let g:colors.gui.bg          = '#ffffff'
let g:colors.gui.offwhite    = '#c7c7c7'
let g:colors.gui.inverse     = '#eff1f2'
let g:colors.gui.gray4       = '#eff1f2'
let g:colors.gui.gray3       = '#b0bec5'
let g:colors.gui.gray2       = '#c4cfd4'
let g:colors.gui.gray1       = '#7e939e'
let g:colors.gui.red         = '#d32f2f'
let g:colors.gui.green       = '#22863a'
let g:colors.gui.blue        = '#1976d2'
let g:colors.gui.purple      = '#6f42c1'

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
call g:HL('IncSearch', g:colors.gui.gray3, g:colors.cterm.gray3, '', '', '')
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
call g:HL('Search', '', '', g:colors.gui.gray3, g:colors.cterm.gray3, '')
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

call g:HL("TSInclude", g:colors.gui.blue, g:colors.cterm.blue, '', '', 'NONE')
call g:HL("TSVariable", g:colors.gui.red, g:colors.cterm.red, '', '', 'NONE')
call g:HL("TSTag", g:colors.gui.red, g:colors.cterm.red, '', '', 'NONE')
call g:HL("TSString", g:colors.gui.green, g:colors.cterm.green, '', '', 'NONE')
call g:HL("TSConstructor", g:colors.gui.fg, g:colors.cterm.fg, '', '', 'NONE')
call g:HL("TSFunction", g:colors.gui.blue, g:colors.cterm.blue, '', '', 'NONE')
call g:HL('TSPunctBracket', g:colors.gui.blue, g:colors.cterm.blue, '', '', 'NONE')
call g:HL('TSPunctDelimiter', g:colors.gui.blue, g:colors.cterm.blue, '', '', 'NONE')
call g:HL('TSParameter', g:colors.gui.red, g:colors.cterm.red, '', '', 'NONE')
call g:HL('TSType', g:colors.gui.blue, g:colors.cterm.blue, '', '','NONE')
call g:HL('TSTagDelimiter', g:colors.gui.blue, g:colors.cterm.blue, '', '', 'NONE')
call g:HL('TSProperty', g:colors.gui.fg, g:colors.cterm.fg, '', '' ,'NONE')
call g:HL('TSMethod', g:colors.gui.blue, g:colors.cterm.blue, '', '','NONE')
call g:HL('TSOperator', g:colors.gui.purple, g:colors.cterm.purple, '', '','NONE')
call g:HL('TSKeyword', g:colors.gui.purple, g:colors.cterm.purple, '', '' ,'NONE')
call g:HL('TSVariableBuiltin', g:colors.gui.blue, g:colors.cterm.blue, '', '', 'NONE')
call g:HL('TSLabel', g:colors.gui.blue, g:colors.cterm.blue, '', '', 'NONE')
call g:HL('TSUnderline', g:colors.gui.blue, g:colors.cterm.blue, '', '', 'NONE')

" Standard Syntax
call g:HL('Comment', g:colors.gui.gray3, g:colors.cterm.gray3, '', '', 'italic')
call g:HL('Constant', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('String', g:colors.gui.green, g:colors.cterm.green, '', '', '')
call g:HL('Character', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('Identifier', g:colors.gui.purple, g:colors.cterm.purple, '', '', 'none')
call g:HL('Keyword', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('Statement', g:colors.gui.purple, g:colors.cterm.purple, '', '', 'none')
call g:HL('Operator', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('PreProc', g:colors.gui.red, g:colors.cterm.red, '', '', 'italic')
call g:HL('Include', g:colors.gui.red, g:colors.cterm.red, '', '', 'italic')
call g:HL('From', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('Define', g:colors.gui.purple, g:colors.cterm.purple, '', '', 'none')
call g:HL('Macro', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('Delimiter', g:colors.gui.fg, g:colors.cterm.fg, '', '', '')
call g:HL('Type', g:colors.gui.red, g:colors.cterm.red, '', '', 'none')
call g:HL('Structure', g:colors.gui.fg, g:colors.cterm.fg, '', '', '')
call g:HL('Special', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('Underlined', g:colors.gui.fg, g:colors.cterm.fg, '', '', 'none')
call g:HL('Error', g:colors.gui.red, g:colors.cterm.red, 'NONE', 'NONE', 'bold')
call g:HL('Todo', g:colors.gui.fg, g:colors.cterm.red, g:colors.gui.gray1, g:colors.cterm.gray1, 'bold')
call g:HL('ExtraWhitespace', '', '', g:colors.gui.red, g:colors.cterm.red, '')

" html
call g:HL('htmlTag', g:colors.gui.fg, g:colors.cterm.fg, '', '', 'none')
call g:HL('htmlTagName', g:colors.gui.green, g:colors.cterm.green, '', '', 'none')
call g:HL('htmlSpecialTagName', g:colors.gui.green, g:colors.cterm.green, '', '', 'none')
call g:HL('htmlArg', g:colors.gui.purple, g:colors.cterm.purple, '', '', 'none')
call g:HL('htmlEndTag', g:colors.gui.fg, g:colors.cterm.fg, '', '', 'none')

" xml
call g:HL('xmlTag', g:colors.gui.fg, g:colors.cterm.fg, '', '', 'none')
call g:HL('xmlTagName', g:colors.gui.green, g:colors.cterm.green, '', '', 'none')
call g:HL('xmlAttrib', g:colors.gui.purple, g:colors.cterm.purple, '', '', 'none')
call g:HL('xmlEndTag', g:colors.gui.green, g:colors.cterm.green, '', '', 'none')

" php
call g:HL('phpUseClass', g:colors.gui.blue, g:colors.cterm.blue, '', '', 'none')
call g:HL('phpParent', g:colors.gui.fg, g:colors.cterm.fg, '', '', 'none')
call g:HL('phpIdentifier', g:colors.gui.fg, g:colors.cterm.fg, '', '', 'none')
call g:HL('phpFunction', g:colors.gui.purple, g:colors.cterm.purple, '', '', 'none')
call g:HL('phpMethod', g:colors.gui.purple, g:colors.cterm.purple, '', '', 'none')
call g:HL('phpKeyword', g:colors.gui.red, g:colors.cterm.red, '', '', 'none')
call g:HL('phpType', g:colors.gui.red, g:colors.cterm.red, '', '', 'none')
call g:HL('phpRegion', g:colors.gui.purple, g:colors.cterm.purple, '', '', 'none')
call g:HL('phpStaticClasses', g:colors.gui.blue, g:colors.cterm.blue, '', '', 'none')
call g:HL('phpClass', g:colors.gui.blue, g:colors.cterm.blue, '', '', 'none')
call g:HL('phpReturn', g:colors.gui.red, g:colors.cterm.red, '', '', 'none')
call g:HL('phpThis', g:colors.gui.blue, g:colors.cterm.blue, '', '', 'none')
call g:HL('phpVarSelector', g:colors.gui.blue, g:colors.cterm.blue, '', '', 'none')

" javascript
call g:HL('jsExportDefault', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('jsObjectColon', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('jsObjectProp', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('jsReturn', g:colors.gui.red, g:colors.cterm.red, '', '', 'none')
call g:HL('jsNull', g:colors.gui.blue, g:colors.cterm.blue, '', '', 'none')
call g:HL('jsConditional', g:colors.gui.red, g:colors.cterm.red, '', '', 'none')

" CSS
call g:HL('cssAttrComma', g:colors.gui.fg, g:colors.cterm.fg, '', '', '')
call g:HL('cssBraces', g:colors.gui.fg, g:colors.cterm.fg, '', '', '')
call g:HL('cssClassName', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('cssIdentifier', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('cssProp', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('cssAttrRegion', g:colors.gui.blue, g:colors.cterm.fg, '', '', 'none')
call g:HL('cssTagName', g:colors.gui.blue, g:colors.cterm.fg, '', '', 'none')
call g:HL('cssDefinition', g:colors.gui.blue, g:colors.cterm.blue, '', '', 'none')
call g:HL('cssStyle', g:colors.gui.blue, g:colors.cterm.blue, '', '', 'none')
call g:HL('cssUnitDecorators', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('cssSelectorOp', g:colors.gui.fg, g:colors.cterm.fg, '', '', '')
call g:HL('cssSelectorOp2', g:colors.gui.fg, g:colors.cterm.fg, '', '', '')

" SCSS
call g:HL('scssVariable', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('scssAttribute', g:colors.gui.red, g:colors.cterm.red, '', '', '')

" GitGutter
call g:HL('GitGutterAdd', g:colors.gui.green, g:colors.cterm.green, '', '', '')
call g:HL('GitGutterDelete', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('GitGutterChange', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('GitGutterChangeDelete', g:colors.gui.red, g:colors.cterm.red, '', '', '')

" Git Commit
call g:HL('gitcommitBranch', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('gitcommitUnmerged', g:colors.gui.green, g:colors.cterm.green, '', '', '')
call g:HL('gitcommitUntrackedFile', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('gitcommitSelectedFile', g:colors.gui.green, g:colors.cterm.green, '', '', '')
call g:HL('gitcommitDiscardedFile', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('gitcommitUnmergedFile', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('gitcommitSelectedType', g:colors.gui.green, g:colors.cterm.green, '', '', '')
call g:HL('gitcommitDiscardedType', g:colors.gui.red, g:colors.cterm.red, '', '', '')

hi link gitcommitNoBranch       gitcommitBranch
hi link gitcommitUntracked      gitcommitComment
hi link gitcommitDiscarded      gitcommitComment
hi link gitcommitSelected       gitcommitComment
hi link gitcommitDiscardedArrow gitcommitDiscardedFile
hi link gitcommitSelectedArrow  gitcommitSelectedFile
hi link gitcommitUnmergedArrow  gitcommitUnmergedFile

" Vim-Fugitive
call g:HL('diffAdded', g:colors.gui.green, g:colors.cterm.green, '', '', '')
call g:HL('diffRemoved', g:colors.gui.red, g:colors.cterm.red, '', '', '')

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
