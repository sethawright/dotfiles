highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'materitermlight'
let s:colors = {'gui' : {} , 'cterm' : {}}

" Color Palette for CTERM
let s:colors.cterm.cursor    = 'NONE'
let s:colors.cterm.bg        = 'NONE'
let s:colors.cterm.fg        = '15'
let s:colors.cterm.offwhite  = '14'
let s:colors.cterm.gray1     = '0'
let s:colors.cterm.gray2     = '7'
let s:colors.cterm.gray3     = '8'
let s:colors.cterm.red       = '1'
let s:colors.cterm.pink      = '16'
let s:colors.cterm.orange    = '10'
let s:colors.cterm.yellow    = '3'
let s:colors.cterm.green     = '2'
let s:colors.cterm.pale_blue = '11'
let s:colors.cterm.blue      = '4'
let s:colors.cterm.cyan      = '6'
let s:colors.cterm.purple    = '5'
let s:colors.cterm.violet    = '12'
let s:colors.cterm.brown     = '13'

" Color Palette for GUI
let s:colors.gui.cursor      = '#ffcc00'
let s:colors.gui.fg          = '#1c262a'
let s:colors.gui.bg          = '#f7f7f7'
let s:colors.gui.offwhite    = '#e5e9ea'
let s:colors.gui.gray1       = '#b0bec5'
let s:colors.gui.gray2       = '#c4cfd4'
let s:colors.gui.gray3       = '#7e939e'
let s:colors.gui.red         = '#e83b3f'
let s:colors.gui.pink        = '#f07178'
let s:colors.gui.orange      = '#f78c6c'
let s:colors.gui.yellow      = '#f6981e'
let s:colors.gui.green       = '#40a33f'
let s:colors.gui.pale_blue   = '#b2ccd6'
let s:colors.gui.blue        = '#1e80f0'
let s:colors.gui.cyan        = '#16afca'
let s:colors.gui.purple      = '#992bae'
let s:colors.gui.violet      = '#bb80b3'
let s:colors.gui.brown       = '#ab7967'

function! s:HL(group, guifg, ctermfg, guibg, ctermbg, attr)
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
call s:HL('Cursor', '', '', s:colors.gui.cursor, s:colors.cterm.cursor, '')
call s:HL('DiffAdd', s:colors.gui.green, s:colors.cterm.green, s:colors.gui.gray1, s:colors.cterm.gray1, '')
call s:HL('DiffChange', s:colors.gui.yellow, s:colors.cterm.yellow, s:colors.gui.gray1, s:colors.cterm.gray1, '')
call s:HL('DiffDelete', s:colors.gui.red, s:colors.cterm.red, s:colors.gui.gray1, s:colors.cterm.gray1, '')
call s:HL('DiffText', s:colors.gui.blue, s:colors.cterm.blue, s:colors.gui.gray1, s:colors.cterm.gray1, '')
call s:HL('Directory', s:colors.gui.blue, s:colors.cterm.blue, '', '', '')
call s:HL('ErrorMsg', s:colors.gui.red, s:colors.cterm.red, s:colors.gui.gray1, s:colors.cterm.gray1, '')
call s:HL('FoldColumn', s:colors.gui.orange, s:colors.cterm.orange, s:colors.gui.gray1, s:colors.cterm.gray1, '')
call s:HL('Folded', s:colors.gui.orange, s:colors.cterm.orange, s:colors.gui.gray1, s:colors.cterm.gray1, '')
call s:HL('IncSearch', s:colors.gui.yellow, s:colors.cterm.yellow, '', '', '')
call s:HL('LineNr', s:colors.gui.gray3, s:colors.cterm.gray1, '', '', '')
call s:HL('ModeMsg', s:colors.gui.green, s:colors.cterm.green, '', '', 'bold')
call s:HL('MoreMsg', s:colors.gui.green, s:colors.cterm.green, '', '', 'bold')
call s:HL('NonText', s:colors.gui.gray3, s:colors.cterm.gray3, '', '', '')
call s:HL('Normal', s:colors.gui.fg, s:colors.cterm.fg, s:colors.gui.bg, 'NONE', '')
call s:HL('Pmenu', s:colors.gui.pale_blue, s:colors.cterm.pale_blue, s:colors.gui.gray3, s:colors.cterm.gray3, '')
call s:HL('PmenuSbar', '', '', s:colors.gui.pale_blue, s:colors.cterm.pale_blue, '')
call s:HL('PmenuSel', s:colors.gui.fg, s:colors.cterm.fg, s:colors.gui.orange, s:colors.cterm.orange, '')
call s:HL('PmenuThumb', '', '', s:colors.gui.orange, s:colors.cterm.orange, '')
call s:HL('Question', s:colors.gui.blue, s:colors.cterm.blue, '', '', '')
call s:HL('Search', '', '', s:colors.gui.purple, s:colors.cterm.purple, '')
call s:HL('SignColumn', '', '', 'NONE', 'NONE', 'none')
call s:HL('SpecialKey', s:colors.gui.gray3, s:colors.cterm.gray3, '', '', '')
call s:HL('SpellBad', s:colors.gui.red, s:colors.cterm.red, s:colors.gui.gray1, s:colors.cterm.gray1, 'undercurl')
call s:HL('SpellCap', s:colors.gui.blue, s:colors.cterm.blue, '', '', 'undercurl')
call s:HL('StatusLine', s:colors.gui.gray1, s:colors.cterm.gray1, s:colors.gui.pale_blue, s:colors.cterm.pale_blue, 'none')
call s:HL('StatusLineNC', s:colors.gui.gray3, s:colors.cterm.gray3, s:colors.gui.gray1, s:colors.cterm.gray1, 'none')
call s:HL('CursorLine', s:colors.gui.fg, s:colors.cterm.fg, s:colors.gui.orange, s:colors.cterm.orange, 'none')
call s:HL('TabLine', s:colors.gui.gray3, s:colors.cterm.gray3, s:colors.gui.gray1, s:colors.cterm.gray1, '')
call s:HL('TabLineFill', '', '', s:colors.gui.gray1, s:colors.cterm.gray1, 'NONE')
call s:HL('TabLineSel', s:colors.gui.orange, s:colors.cterm.orange, s:colors.gui.gray3, s:colors.cterm.gray3, 'NONE')
call s:HL('Title', s:colors.gui.green, s:colors.cterm.green, '', '', 'none')
call s:HL('VertSplit', s:colors.gui.gray1, s:colors.cterm.gray1, 'NONE', 'NONE', 'NONE')
call s:HL('Visual', '', '', s:colors.gui.offwhite, s:colors.cterm.offwhite, '')
call s:HL('WarningMsg', s:colors.gui.red, s:colors.cterm.red, '', '', '')
call s:HL('WildMenu', s:colors.gui.fg, s:colors.cterm.fg, s:colors.gui.orange, s:colors.cterm.orange, '')

" " Standard Syntax
call s:HL('Comment', s:colors.gui.gray2, s:colors.cterm.gray2, '', '', '')
call s:HL('Constant', s:colors.gui.orange, s:colors.cterm.orange, '', '', '')
call s:HL('String', s:colors.gui.green, s:colors.cterm.green, '', '', '')
call s:HL('Character', s:colors.gui.cyan, s:colors.cterm.cyan, '', '', '')
call s:HL('Identifier', s:colors.gui.fg, s:colors.cterm.fg, '', '', 'none')
call s:HL('Keyword', s:colors.gui.purple, s:colors.cterm.purple, '', '', '')
call s:HL('Statement', s:colors.gui.purple, s:colors.cterm.purple, '', '', '')
call s:HL('Operator', s:colors.gui.cyan, s:colors.cterm.cyan, '', '', '')
call s:HL('PreProc', s:colors.gui.purple, s:colors.cterm.purple, '', '', 'bold')
call s:HL('Include', s:colors.gui.purple, s:colors.cterm.purple, '', '', '')
call s:HL('From', s:colors.gui.purple, s:colors.cterm.purple, '', '', '')
call s:HL('Define', s:colors.gui.purple, s:colors.cterm.purple, '', '', 'none')
call s:HL('Macro', s:colors.gui.purple, s:colors.cterm.purple, '', '', '')
call s:HL('Delimiter', s:colors.gui.cyan, s:colors.cterm.cyan, '', '', '')
call s:HL('Type', s:colors.gui.purple, s:colors.cterm.purple, '', '', '')
call s:HL('Structure', s:colors.gui.cyan, s:colors.cterm.cyan, '', '', '')
call s:HL('Special', s:colors.gui.purple, s:colors.cterm.purple, '', '', '')
call s:HL('Underlined', s:colors.gui.blue, s:colors.cterm.blue, '', '', 'none')
call s:HL('Error', s:colors.gui.red, s:colors.cterm.red, s:colors.gui.gray1, s:colors.cterm.gray1, 'bold')
call s:HL('Todo', s:colors.gui.orange, s:colors.cterm.red, s:colors.gui.gray1, s:colors.cterm.gray1, 'bold')
call s:HL('ExtraWhitespace', '', '', s:colors.gui.orange, s:colors.cterm.orange, '')

" " CSS
call s:HL('cssAttrComma', s:colors.gui.fg, s:colors.cterm.fg, '', '', '')
call s:HL('cssAttributeSelector', s:colors.gui.red, s:colors.cterm.red, '', '', '')
call s:HL('cssBraces', s:colors.gui.cyan, s:colors.cterm.cyan, '', '', '')
call s:HL('cssClassName', s:colors.gui.yellow, s:colors.cterm.yellow, '', '', '')
call s:HL('cssClassNameDot', s:colors.gui.cyan, s:colors.cterm.cyan, '', '', '')
call s:HL('cssFunctionName', s:colors.gui.blue, s:colors.cterm.blue, '', '', '')
call s:HL('cssPseudoClassFn', s:colors.gui.purple, s:colors.cterm.purple, '', '', '')
call s:HL('cssMediaProp', s:colors.gui.pale_blue, s:colors.cterm.pale_blue, '', '', '')
call s:HL('cssIdentifier', s:colors.gui.purple, s:colors.cterm.purple, '', '', '')
call s:HL('cssInclude', s:colors.gui.fg, s:colors.cterm.fg, '', '', '')
call s:HL('cssIncludeKeyword', s:colors.gui.purple, s:colors.cterm.purple, '', '', 'bold')
call s:HL('cssProp', s:colors.gui.fg, s:colors.cterm.fg, '', '', '')
call s:HL('cssSelectorOp', s:colors.gui.violet, s:colors.cterm.violet, '', '', '')
call s:HL('cssSelectorOp2', s:colors.gui.violet, s:colors.cterm.violet, '', '', '')

" Git Commit
call s:HL('gitcommitBranch', s:colors.gui.blue, s:colors.cterm.blue, '', '', '')
call s:HL('gitcommitUnmerged', s:colors.gui.green, s:colors.cterm.green, '', '', '')
call s:HL('gitcommitUntrackedFile', s:colors.gui.cyan, s:colors.cterm.cyan, '', '', '')
call s:HL('gitcommitSelectedFile', s:colors.gui.green, s:colors.cterm.green, '', '', '')
call s:HL('gitcommitDiscardedFile', s:colors.gui.red, s:colors.cterm.red, '', '', '')
call s:HL('gitcommitUnmergedFile', s:colors.gui.yellow, s:colors.cterm.yellow, '', '', '')
call s:HL('gitcommitSelectedType', s:colors.gui.green, s:colors.cterm.green, '', '', '')
call s:HL('gitcommitDiscardedType', s:colors.gui.red, s:colors.cterm.red, '', '', '')
hi link gitcommitNoBranch       gitcommitBranch
hi link gitcommitUntracked      gitcommitComment
hi link gitcommitDiscarded      gitcommitComment
hi link gitcommitSelected       gitcommitComment
hi link gitcommitDiscardedArrow gitcommitDiscardedFile
hi link gitcommitSelectedArrow  gitcommitSelectedFile
hi link gitcommitUnmergedArrow  gitcommitUnmergedFile

" " HTML
call s:HL('htmlTag', s:colors.gui.cyan, s:colors.cterm.cyan, '', '', '')
call s:HL('htmlEndTag', s:colors.gui.cyan, s:colors.cterm.cyan, '', '', '')
call s:HL('htmlTagName', s:colors.gui.red, s:colors.cterm.red, '', '', '')
call s:HL('htmlTagN', s:colors.gui.red, s:colors.cterm.red, '', '', '')
call s:HL('htmlArg', s:colors.gui.purple, s:colors.cterm.purple, '', '', '')
call s:HL('htmlLink', s:colors.gui.fg, s:colors.cterm.fg, '', '', '')
call s:HL('htmlSpecialTagName', s:colors.gui.red, s:colors.cterm.red, '', '', '')
call s:HL('htmlSpecialChar', s:colors.gui.orange, s:colors.cterm.orange, '', '', '')
call s:HL('htmlTitle', s:colors.gui.fg, s:colors.cterm.fg, '', '', '')

" Email
call s:HL('mailHeaderEmail', s:colors.gui.yellow, s:colors.cterm.yellow, '', '', '')
call s:HL('mailQuoted1', s:colors.gui.gray3, s:colors.cterm.gray3, '', '', '')
call s:HL('mailQuoted2', s:colors.gui.gray1, s:colors.cterm.gray1, '', '', '')
call s:HL('mailQuoted3', s:colors.gui.gray1, s:colors.cterm.gray1, '', '', '')

" Javascript
call s:HL('javaScriptBraces', s:colors.gui.cyan, s:colors.cterm.cyan, '', '', '')
call s:HL('javaScriptNull', s:colors.gui.orange, s:colors.cterm.orange, '', '', '')
call s:HL('javaScriptIdentifier', s:colors.gui.purple, s:colors.cterm.purple, '', '', '')
call s:HL('javaScriptNumber', s:colors.gui.orange, s:colors.cterm.orange, '', '', '')
call s:HL('javaScriptRequire', s:colors.gui.blue, s:colors.cterm.blue, '', '', '')

" pangloss/vim-javascript
call s:HL('Noise', s:colors.gui.cyan, s:colors.cterm.cyan, '', '', '')
call s:HL('jsArrowFunction', s:colors.gui.purple, s:colors.cterm.purple, '', '', '')
call s:HL('jsClassDefinition', s:colors.gui.yellow, s:colors.cterm.yellow, '', '', '')
call s:HL('jsClassKeyword', s:colors.gui.purple, s:colors.cterm.purple, '', '', '')
call s:HL('jsFuncCall', s:colors.gui.blue, s:colors.cterm.blue, '', '', '')
call s:HL('jsFunction', s:colors.gui.purple, s:colors.cterm.purple, '', '', '')
call s:HL('jsClassFuncName', s:colors.gui.blue, s:colors.cterm.blue, '', '', '')
call s:HL('jsGlobalObjects', s:colors.gui.yellow, s:colors.cterm.yellow, '', '', '')
call s:HL('jsGlobalNodeObjects', s:colors.gui.blue, s:colors.cterm.blue, '', '', '')
call s:HL('jsObjectFuncName', s:colors.gui.blue, s:colors.cterm.blue, '', '', '')
call s:HL('jsObjectKey', s:colors.gui.blue, s:colors.cterm.blue, '', '', '')
call s:HL('jsNull', s:colors.gui.orange, s:colors.cterm.orange, '', '', '')
call s:HL('jsStorageClass', s:colors.gui.purple, s:colors.cterm.purple, '', '', '')
call s:HL('jsFuncArgs', s:colors.gui.orange, s:colors.cterm.orange, '', '', '')
call s:HL('jsThis', s:colors.gui.red, s:colors.cterm.red, '', '', '')
call s:HL('jsUndefined', s:colors.gui.orange, s:colors.cterm.orange, '', '', '')

" Markdown
call s:HL('markdownCode', s:colors.gui.orange, s:colors.cterm.orange, '', '', '')
call s:HL('markdownCodeBlock', '', '', s:colors.gui.gray1, s:colors.cterm.gray1, '')
call s:HL('markdownCodeDelimiter', s:colors.gui.gray1, s:colors.cterm.gray1, '', '', '')
call s:HL('markdownHeadingDelimiter', s:colors.gui.green, s:colors.cterm.green, '', '', '')
call s:HL('markdownHeadingRule', s:colors.gui.green, s:colors.cterm.green, '', '', '')
call s:HL('markdownLinkText', s:colors.gui.blue, s:colors.cterm.blue, '', '', '')
call s:HL('markdownItalic', s:colors.gui.red, s:colors.cterm.red, '', '', '')
call s:HL('markdownBold', s:colors.gui.red, s:colors.cterm.red, '', '', '')
call s:HL('markdownListMarker', s:colors.gui.fg, s:colors.cterm.fg, '', '', '')
call s:HL('markdownOrderedListMarker', s:colors.gui.fg, s:colors.cterm.fg, '', '', '')

" Vimwiki
call s:HL('VimwikiHeader1', s:colors.gui.blue, s:colors.cterm.blue, '', '', '')
call s:HL('VimwikiHeader2', s:colors.gui.orange, s:colors.cterm.orange, '', '', '')
call s:HL('VimwikiHeaderChar', s:colors.gui.gray3, s:colors.cterm.gray3, '', '', '')
call s:HL('VimwikiListTodo', s:colors.gui.purple, s:colors.cterm.purple, '', '', '')
call s:HL('VimwikiPre', s:colors.gui.gray1, s:colors.cterm.gray1, '', '', '')
call s:HL('VimwikiCode', s:colors.gui.orange, s:colors.cterm.orange, '', '', '')
call s:HL('VimwikiCodeChar', s:colors.gui.gray1, s:colors.cterm.gray1, '', '', '')

" PHP
call s:HL('phpRegion', s:colors.gui.blue, s:colors.cterm.blue, '', '', '')
call s:HL('phpClass', s:colors.gui.yellow, s:colors.cterm.yellow, '', '', '')
call s:HL('phpClassExtends', s:colors.gui.green, s:colors.cterm.green, '', '', '')
call s:HL('phpStaticClasses', s:colors.gui.yellow, s:colors.cterm.yellow, '', '', '')
call s:HL('phpMethod', s:colors.gui.blue, s:colors.cterm.blue, '', '', '')
call s:HL('phpFunctions', s:colors.gui.blue, s:colors.cterm.blue, '', '', '')
call s:HL('phpParent', s:colors.gui.cyan, s:colors.cterm.cyan, '', '', '')
call s:HL('phpThis', s:colors.gui.red, s:colors.cterm.red, '', '', '')

" Ruby
call s:HL('rubyInclude', s:colors.gui.blue, s:colors.cterm.blue, '', '', '')
call s:HL('rubyFunction', s:colors.gui.blue, s:colors.cterm.blue, '', '', '')
call s:HL('rubyLocalVariableOrMethod', s:colors.gui.orange, s:colors.cterm.orange, '', '', '')
call s:HL('rubyPseudoVariable', s:colors.gui.red, s:colors.cterm.red, '', '', '')

" Vim-Fugitive
call s:HL('diffAdded', s:colors.gui.green, s:colors.cterm.green, '', '', '')
call s:HL('diffRemoved', s:colors.gui.red, s:colors.cterm.red, '', '', '')
"
" XML
call s:HL('xmlAttrib', s:colors.gui.yellow, s:colors.cterm.yellow, '', '', '')
call s:HL('xmlTag', s:colors.gui.red, s:colors.cterm.red, '', '', '')
call s:HL('xmlTagName', s:colors.gui.red, s:colors.cterm.red, '', '', '')
call s:HL('xmlEndTag', s:colors.gui.red, s:colors.cterm.red, '', '', '')

" Other stuff
call s:HL('CursorLineNr', s:colors.gui.orange, s:colors.cterm.orange, '', '', '')
call s:HL('CtrlPMatch', '', '', '', '', 'bold')
hi MatchParen cterm=bold,underline ctermbg=NONE guibg=NONE gui=bold,underline guibg=NONE guifg=NONE
hi link CtrlSpaceNormal Normal
hi link CtrlSpaceSelected CursorLine
hi link CtrlSpaceStatus Ctrlpdark
