" Color Palette for CTERM
let g:colors.cterm.cursor    = 'NONE'
let g:colors.cterm.bg        = 'NONE'
let g:colors.cterm.fg        = '15'
let g:colors.cterm.offwhite  = '14'
let g:colors.cterm.gray1     = '0'
let g:colors.cterm.gray2     = '7'
let g:colors.cterm.gray3     = '8'
let g:colors.cterm.red       = '1'
let g:colors.cterm.pink      = '16'
let g:colors.cterm.orange    = '10'
let g:colors.cterm.yellow    = '3'
let g:colors.cterm.green     = '2'
let g:colors.cterm.pale_blue = '11'
let g:colors.cterm.blue      = '4'
let g:colors.cterm.cyan      = '6'
let g:colors.cterm.purple    = '5'
let g:colors.cterm.violet    = '12'
let g:colors.cterm.brown     = '13'

let g:colors.gui.red         = '#FF5370'
let g:colors.gui.pink        = '#F07178'
let g:colors.gui.orange      = '#F78C6C'
let g:colors.gui.yellow      = '#FFCB6B'
let g:colors.gui.green       = '#C3E88D'
let g:colors.gui.pale_blue   = '#B2CCD6'
let g:colors.gui.blue        = '#82AAFF'
let g:colors.gui.cyan        = '#89DDFF'
let g:colors.gui.purple      = '#C792EA'
let g:colors.gui.violet      = '#BB80B3'
let g:colors.gui.brown       = '#C17E70'

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

call g:HL('DiffAdd', g:colors.gui.green, g:colors.cterm.green, g:colors.gui.bg, g:colors.cterm.bg, '')
call g:HL('DiffChange', g:colors.gui.yellow, g:colors.cterm.yellow, g:colors.gui.bg, g:colors.cterm.bg, '')
call g:HL('DiffDelete', g:colors.gui.red, g:colors.cterm.red, g:colors.gui.bg, g:colors.cterm.bg, '')
call g:HL('DiffText', g:colors.gui.blue, g:colors.cterm.blue, g:colors.gui.bg, g:colors.cterm.bg, '')
call g:HL('Directory', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('ErrorMsg', g:colors.gui.red, g:colors.cterm.red, 'NONE', 'NONE', '')
call g:HL('FoldColumn', g:colors.gui.orange, g:colors.cterm.orange, g:colors.gui.gray1, g:colors.cterm.gray1, '')
call g:HL('Folded', g:colors.gui.orange, g:colors.cterm.orange, g:colors.gui.gray1, g:colors.cterm.gray1, '')
call g:HL('IncSearch', g:colors.gui.yellow, g:colors.cterm.yellow, '', '', '')
call g:HL('LineNr', g:colors.gui.gray3, g:colors.cterm.gray3, '', '', '')
call g:HL('ModeMsg', g:colors.gui.green, g:colors.cterm.green, '', '', 'bold')
call g:HL('MoreMsg', g:colors.gui.green, g:colors.cterm.green, '', '', 'bold')
call g:HL('NonText', g:colors.gui.gray3, g:colors.cterm.gray3, '', '', '')
call g:HL('Normal', g:colors.gui.fg, g:colors.cterm.fg, g:colors.gui.bg, 'NONE', '')
call g:HL('Pmenu', g:colors.gui.fg, g:colors.cterm.fg, g:colors.gui.inverse, g:colors.cterm.gray3, '')
call g:HL('PmenuSbar', '', '', g:colors.gui.pale_blue, g:colors.cterm.pale_blue, '')
call g:HL('PmenuSel', g:colors.gui.fg, g:colors.cterm.fg, g:colors.gui.gray2, g:colors.cterm.gray2, '')
call g:HL('PmenuThumb', '', '', g:colors.gui.orange, g:colors.cterm.orange, '')
call g:HL('Question', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('Search', '', '', g:colors.gui.purple, g:colors.cterm.purple, '')
call g:HL('SignColumn', '', '', 'NONE', 'NONE', 'none')
call g:HL('SpecialKey', g:colors.gui.gray3, g:colors.cterm.gray3, '', '', '')
call g:HL('SpellBad', g:colors.gui.red, g:colors.cterm.red, g:colors.gui.gray1, g:colors.cterm.gray1, 'undercurl')
call g:HL('SpellCap', g:colors.gui.blue, g:colors.cterm.blue, '', '', 'undercurl')
call g:HL('StatusLine', g:colors.gui.gray1, g:colors.cterm.gray1, g:colors.gui.gray3, g:colors.cterm.gray3, 'none')
call g:HL('StatusLineNC', g:colors.gui.gray2, g:colors.cterm.gray1, g:colors.gui.gray4, g:colors.cterm.bg, 'none')
call g:HL('TabLine', g:colors.gui.fg, g:colors.cterm.fg, g:colors.gui.gray4, g:colors.cterm.gray3, '')
call g:HL('TabLineFill', '', '', g:colors.gui.gray4, g:colors.cterm.gray3, 'NONE')
call g:HL('TabLineSel', g:colors.gui.fg, g:colors.cterm.fg, g:colors.gui.gray3, g:colors.cterm.gray2, 'NONE')
call g:HL('Title', g:colors.gui.green, g:colors.cterm.green, '', '', 'none')
call g:HL('VertSplit', g:colors.gui.gray3, g:colors.cterm.gray3, 'NONE', 'NONE', 'NONE')
call g:HL('Visual', '', '', g:colors.gui.offwhite, g:colors.cterm.offwhite, '')
call g:HL('WarningMsg', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('WildMenu', g:colors.gui.fg, g:colors.cterm.fg, g:colors.gui.orange, g:colors.cterm.orange, '')

call g:HL('BufferCurrent', g:colors.gui.fg, g:colors.cterm.fg, g:colors.gui.gray3, g:colors.cterm.gray3, '')
call g:HL('BufferCurrentIndex', g:colors.gui.gray4, g:colors.cterm.gray3, g:colors.gui.gray3, g:colors.cterm.gray3, '')
call g:HL('BufferCurrentMod', g:colors.gui.blue, g:colors.cterm.blue, g:colors.gui.gray3, g:colors.cterm.gray3, '')
call g:HL('BufferCurrentSign', g:colors.gui.blue, g:colors.cterm.blue, g:colors.gui.gray3, g:colors.cterm.gray3, '')
call g:HL('BufferCurrentTarget', g:colors.gui.red, g:colors.cterm.red, g:colors.gui.gray3, g:colors.cterm.gray3, 'bold')

call g:HL('BufferVisible', g:colors.gui.gray2, g:colors.cterm.gray2, g:colors.gui.gray4, g:colors.cterm.gray3, '')
call g:HL('BufferVisibleIndex', g:colors.gui.gray2, g:colors.cterm.gray2, g:colors.gui.gray4, g:colors.cterm.gray3, '')
call g:HL('BufferVisibleMod', g:colors.gui.gray2, g:colors.cterm.gray2, g:colors.gui.gray4, g:colors.cterm.gray3, '')
call g:HL('BufferVisibleSign', g:colors.gui.blue, g:colors.cterm.blue, g:colors.gui.gray4, g:colors.cterm.gray3, '')
call g:HL('BufferVisibleTarget', g:colors.gui.red, g:colors.cterm.gray2, g:colors.gui.gray4, g:colors.cterm.gray3, 'bold')

call g:HL('BufferInactive', g:colors.gui.gray2, g:colors.cterm.gray2, g:colors.gui.gray4, g:colors.cterm.gray3, '')
call g:HL('BufferInactiveIndex', g:colors.gui.gray2, g:colors.cterm.gray2, g:colors.gui.gray4, g:colors.cterm.gray3, '')
call g:HL('BufferInactiveMod', g:colors.gui.blue, g:colors.cterm.blue, g:colors.gui.gray4, g:colors.cterm.gray3, '')
call g:HL('BufferInactiveSign', g:colors.gui.gray2, g:colors.cterm.gray2, g:colors.gui.gray4, g:colors.cterm.gray3, '')
call g:HL('BufferInactiveTarget', g:colors.gui.red, g:colors.cterm.gray2, g:colors.gui.gray4, g:colors.cterm.gray3, 'bold')

call g:HL('BufferTabpages', g:colors.gui.blue, g:colors.cterm.blue, g:colors.gui.gray3, g:colors.cterm.gray3, 'bold')
call g:HL('BufferTabpagesFill', g:colors.gui.purple, g:colors.cterm.purple, g:colors.gui.gray3, g:colors.cterm.gray3, '')

hi link BufferCurrentIcon BufferCurrent
hi link BufferVisibleIcon BufferVisible
hi link BufferInactiveIcon BufferInactive
hi link BufferOffset BufferTabpageFill

" Standard Syntax
call g:HL('Comment', g:colors.gui.gray3, g:colors.cterm.gray3, '', '', 'italic')
call g:HL('Constant', g:colors.gui.orange, g:colors.cterm.orange, '', '', '')
call g:HL('String', g:colors.gui.green, g:colors.cterm.green, '', '', '')
call g:HL('Character', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', '')
call g:HL('Identifier', g:colors.gui.fg, g:colors.cterm.fg, '', '', 'none')
call g:HL('Keyword', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('Statement', g:colors.gui.purple, g:colors.cterm.purple, '', '', 'italic')
call g:HL('Operator', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', '')
call g:HL('PreProc', g:colors.gui.purple, g:colors.cterm.purple, '', '', 'bold')
call g:HL('Include', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', 'italic')
call g:HL('From', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('Define', g:colors.gui.purple, g:colors.cterm.purple, '', '', 'none')
call g:HL('Macro', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('Delimiter', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', '')
call g:HL('Type', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('Structure', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', '')
call g:HL('Special', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('Underlined', g:colors.gui.blue, g:colors.cterm.blue, '', '', 'none')
call g:HL('Error', g:colors.gui.red, g:colors.cterm.red, 'NONE', 'NONE', 'bold')
call g:HL('Todo', g:colors.gui.orange, g:colors.cterm.red, g:colors.gui.gray1, g:colors.cterm.gray1, 'bold')
call g:HL('ExtraWhitespace', '', '', g:colors.gui.orange, g:colors.cterm.orange, '')

" CSS
call g:HL('cssAttrComma', g:colors.gui.fg, g:colors.cterm.fg, '', '', '')
call g:HL('cssAttributeSelector', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('cssBraces', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', '')
call g:HL('cssClassName', g:colors.gui.yellow, g:colors.cterm.yellow, '', '', '')
call g:HL('cssClassNameDot', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', '')
call g:HL('cssFunctionName', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('cssPseudoClassFn', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('cssMediaProp', g:colors.gui.pale_blue, g:colors.cterm.pale_blue, '', '', '')
call g:HL('cssIdentifier', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('cssInclude', g:colors.gui.fg, g:colors.cterm.fg, '', '', '')
call g:HL('cssIncludeKeyword', g:colors.gui.purple, g:colors.cterm.purple, '', '', 'bold')
call g:HL('cssProp', g:colors.gui.fg, g:colors.cterm.fg, '', '', '')
call g:HL('cssSelectorOp', g:colors.gui.violet, g:colors.cterm.violet, '', '', '')
call g:HL('cssSelectorOp2', g:colors.gui.violet, g:colors.cterm.violet, '', '', '')

" SCSS
call g:HL('scssSelectorChar', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', '')
call g:HL('scssSelectorName', g:colors.gui.yellow, g:colors.cterm.yellow, '', '', 'italic')
call g:HL('scssVariable', g:colors.gui.red, g:colors.cterm.red, '', '', '')

" Git Commit
call g:HL('gitcommitBranch', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('gitcommitUnmerged', g:colors.gui.green, g:colors.cterm.green, '', '', '')
call g:HL('gitcommitUntrackedFile', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', '')
call g:HL('gitcommitSelectedFile', g:colors.gui.green, g:colors.cterm.green, '', '', '')
call g:HL('gitcommitDiscardedFile', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('gitcommitUnmergedFile', g:colors.gui.yellow, g:colors.cterm.yellow, '', '', '')
call g:HL('gitcommitSelectedType', g:colors.gui.green, g:colors.cterm.green, '', '', '')
call g:HL('gitcommitDiscardedType', g:colors.gui.red, g:colors.cterm.red, '', '', '')
hi link gitcommitNoBranch       gitcommitBranch
hi link gitcommitUntracked      gitcommitComment
hi link gitcommitDiscarded      gitcommitComment
hi link gitcommitSelected       gitcommitComment
hi link gitcommitDiscardedArrow gitcommitDiscardedFile
hi link gitcommitSelectedArrow  gitcommitSelectedFile
hi link gitcommitUnmergedArrow  gitcommitUnmergedFile

" " HTML
call g:HL('htmlTag', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', 'italic')
call g:HL('htmlEndTag', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', '')
call g:HL('htmlTagName', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('htmlTagN', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('htmlArg', g:colors.gui.purple, g:colors.cterm.purple, '', '', 'italic')
call g:HL('htmlLink', g:colors.gui.fg, g:colors.cterm.fg, '', '', '')
call g:HL('htmlSpecialTagName', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('htmlSpecialChar', g:colors.gui.orange, g:colors.cterm.orange, '', '', '')
call g:HL('htmlTitle', g:colors.gui.fg, g:colors.cterm.fg, '', '', '')

" Email
call g:HL('mailHeaderEmail', g:colors.gui.yellow, g:colors.cterm.yellow, '', '', '')
call g:HL('mailQuoted1', g:colors.gui.gray3, g:colors.cterm.gray3, '', '', '')
call g:HL('mailQuoted2', g:colors.gui.gray1, g:colors.cterm.gray1, '', '', '')
call g:HL('mailQuoted3', g:colors.gui.gray1, g:colors.cterm.gray1, '', '', '')

" Javascript
call g:HL('javaScript', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('javaScriptBraces', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', '')
call g:HL('javaScriptNull', g:colors.gui.orange, g:colors.cterm.orange, '', '', '')
call g:HL('javaScriptIdentifier', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('javaScriptNumber', g:colors.gui.orange, g:colors.cterm.orange, '', '', '')
call g:HL('javaScriptRequire', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')

" pangloss/vim-javascript
call g:HL('Noise', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', '')
call g:HL('jsArrowFunction', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('jsClassDefinition', g:colors.gui.yellow, g:colors.cterm.yellow, '', '', '')
call g:HL('jsVariableDef', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('jsClassKeyword', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('jsFuncCall', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('jsFunction', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('jsClassFuncName', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('jsGlobalObjects', g:colors.gui.yellow, g:colors.cterm.yellow, '', '', '')
call g:HL('jsGlobalNodeObjects', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('jsObjectFuncName', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('jsObjectKey', g:colors.gui.fg, g:colors.cterm.fg, '', '', '')
call g:HL('jsNull', g:colors.gui.orange, g:colors.cterm.orange, '', '', '')
call g:HL('jsStorageClass', g:colors.gui.purple, g:colors.cterm.purple, '', '', 'italic')
call g:HL('jsExport', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', 'italic')
call g:HL('jsReturn', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', 'italic')
call g:HL('jsExportDefault', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', 'italic')
call g:HL('jsFuncArgs', g:colors.gui.orange, g:colors.cterm.orange, '', '', '')
call g:HL('jsThis', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('jsUndefined', g:colors.gui.orange, g:colors.cterm.orange, '', '', '')

" Markdown
call g:HL('markdownCode', '', '', g:colors.gui.gray1, g:colors.cterm.gray1, '')
call g:HL('markdownCodeBlock', '', '', g:colors.gui.gray1, g:colors.cterm.gray1, '')
call g:HL('markdownCodeDelimiter', g:colors.gui.gray1, g:colors.cterm.gray1, '', '', '')
call g:HL('markdownHeadingDelimiter', g:colors.gui.gray3, g:colors.cterm.gray3, '', '', '')
call g:HL('markdownHeadingRule', g:colors.gui.green, g:colors.cterm.green, '', '', '')
call g:HL('markdownLinkText', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('markdownItalic', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('markdownBold', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('markdownListMarker', g:colors.gui.fg, g:colors.cterm.fg, '', '', '')
call g:HL('markdownOrderedListMarker', g:colors.gui.fg, g:colors.cterm.fg, '', '', '')

" Vimwiki
call g:HL('VimwikiHeader1', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('VimwikiHeader2', g:colors.gui.orange, g:colors.cterm.orange, '', '', '')
call g:HL('VimwikiHeaderChar', g:colors.gui.gray3, g:colors.cterm.gray3, '', '', '')
call g:HL('VimwikiListTodo', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('VimwikiPre', g:colors.gui.gray1, g:colors.cterm.gray1, '', '', '')
call g:HL('VimwikiCode', g:colors.gui.orange, g:colors.cterm.orange, '', '', '')
call g:HL('VimwikiCodeChar', g:colors.gui.gray1, g:colors.cterm.gray1, '', '', '')

" PHP
call g:HL('phpInclude', g:colors.gui.orange, g:colors.cterm.orange, '', '', '')
call g:HL('phpUseClass', g:colors.gui.yellow, g:colors.cterm.yellow, '', '', '')
call g:HL('phpRegion', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('phpClass', g:colors.gui.yellow, g:colors.cterm.yellow, '', '', '')
call g:HL('phpClassExtends', g:colors.gui.green, g:colors.cterm.green, '', '', '')
call g:HL('phpStaticClasses', g:colors.gui.yellow, g:colors.cterm.yellow, '', '', '')
call g:HL('phpMethod', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('phpFunctions', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('phpParent', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', '')
call g:HL('phpReturn', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', 'italic')
call g:HL('phpThis', g:colors.gui.red, g:colors.cterm.red, '', '', 'italic')
call g:HL('phpType', g:colors.gui.purple, g:colors.cterm.purple, '', '', '')
call g:HL('phpUseNamespaceSeparator', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', '')
call g:HL('phpDocTags', g:colors.gui.orange, g:colors.cterm.orange, '', '', 'italic')
call g:HL('phpDocParam', g:colors.gui.yellow, g:colors.cterm.yellow, '', '', 'italic')
call g:HL('phpVarSelector', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', 'italic')
call g:HL('phpDocNamespaceSeparator', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', 'italic')

" GitGutter
call g:HL('GitGutterAdd', g:colors.gui.green, g:colors.cterm.green, '', '', '')
call g:HL('GitGutterDelete', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('GitGutterChange', g:colors.gui.yellow, g:colors.cterm.yellow, '', '', '')
call g:HL('GitGutterChangeDelete', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('GitSignsAdd', g:colors.gui.green, g:colors.cterm.green, '', '', '')
call g:HL('GitSignsDelete', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('GitSignsChange', g:colors.gui.yellow, g:colors.cterm.yellow, '', '', '')

" Ruby
call g:HL('rubyInclude', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('rubyFunction', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('rubyLocalVariableOrMethod', g:colors.gui.orange, g:colors.cterm.orange, '', '', '')
call g:HL('rubyPseudoVariable', g:colors.gui.red, g:colors.cterm.red, '', '', '')

" Vim-Fugitive
call g:HL('diffAdded', g:colors.gui.green, g:colors.cterm.green, '', '', '')
call g:HL('diffRemoved', g:colors.gui.red, g:colors.cterm.red, '', '', '')
"
" XML
call g:HL('xmlAttrib', g:colors.gui.yellow, g:colors.cterm.yellow, '', '', '')
call g:HL('xmlTag', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('xmlTagName', g:colors.gui.red, g:colors.cterm.red, '', '', '')
call g:HL('xmlEndTag', g:colors.gui.red, g:colors.cterm.red, '', '', '')

" Sass
call g:HL('sassVariable', g:colors.gui.orange, g:colors.cterm.orange, '', '', '')

" Vue
call g:HL('vueSurroundingTag', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', '')
call g:HL('vueObjectFuncName', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('vueObjectKey', g:colors.gui.blue, g:colors.cterm.blue, '', '', '')
call g:HL('VueKey', g:colors.gui.cyan, g:colors.cterm.cyan, '', '', '')

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

let g:indentLine_color_gui = g:colors.gui.gray4
