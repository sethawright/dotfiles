" vi:syntax=vim

" espresso.vim (https://github.com/asethwright/espresso.vim)
" by Seth Wright (http://chriskempson.com)
" Based on Base 16 scheme by Chris Kempson (http://chriskempson.com)

" This enables the coresponding base16-shell script to run so that
" :colorscheme works in terminals supported by base16-shell scripts
" User must set this variable in .vimrc
"   let g:base16_shell_path=base16-builder/output/shell/
if !has('gui_running')
  if exists("g:base16_shell_path")
    execute "silent !/bin/sh "/Users/seth/dotfiles/espresso.sh"
  endif
endif

" GUI color definitions
let s:gui00        = "f8f8f8"
let g:base16_gui00 = "f8f8f8"
let s:gui01        = "e8e8e8"
let g:base16_gui01 = "e8e8e8"
let s:gui02        = "d8d8d8"
let g:base16_gui02 = "d8d8d8"
let s:gui03        = "b8b8b8"
let g:base16_gui03 = "b8b8b8"
let s:gui04        = "585858"
let g:base16_gui04 = "585858"
let s:gui05        = "383838"
let g:base16_gui05 = "383838"
let s:gui06        = "282828"
let g:base16_gui06 = "282828"
let s:gui07        = "181818"
let g:base16_gui07 = "181818"
let s:gui08        = "ab4642"
let g:base16_gui08 = "ab4642"
let s:gui09        = "dc9656"
let g:base16_gui09 = "dc9656"
let s:gui0A        = "f7ca88"
let g:base16_gui0A = "f7ca88"
let s:gui0B        = "a1b56c"
let g:base16_gui0B = "a1b56c"
let s:gui0C        = "86c1b9"
let g:base16_gui0C = "86c1b9"
let s:gui0D        = "7cafc2"
let g:base16_gui0D = "7cafc2"
let s:gui0E        = "ba8baf"
let g:base16_gui0E = "ba8baf"
let s:gui0F        = "a16946"
let g:base16_gui0F = "a16946"

" Terminal color definitions
let s:cterm00        = "00"
let g:base16_cterm00 = "00"
let s:cterm03        = "08"
let g:base16_cterm03 = "08"
let s:cterm05        = "07"
let g:base16_cterm05 = "07"
let s:cterm07        = "15"
let g:base16_cterm07 = "15"
let s:cterm08        = "01"
let g:base16_cterm08 = "01"
let s:cterm0A        = "03"
let g:base16_cterm0A = "03"
let s:cterm0B        = "02"
let g:base16_cterm0B = "02"
let s:cterm0C        = "06"
let g:base16_cterm0C = "06"
let s:cterm0D        = "04"
let g:base16_cterm0D = "04"
let s:cterm0E        = "05"
let g:base16_cterm0E = "05"
if exists('base16colorspace') && base16colorspace == "256"
  let s:cterm01        = "18"
  let g:base16_cterm01 = "18"
  let s:cterm02        = "19"
  let g:base16_cterm02 = "19"
  let s:cterm04        = "20"
  let g:base16_cterm04 = "20"
  let s:cterm06        = "21"
  let g:base16_cterm06 = "21"
  let s:cterm09        = "16"
  let g:base16_cterm09 = "16"
  let s:cterm0F        = "17"
  let g:base16_cterm0F = "17"
else
  let s:cterm01        = "10"
  let g:base16_cterm01 = "10"
  let s:cterm02        = "11"
  let g:base16_cterm02 = "11"
  let s:cterm04        = "12"
  let g:base16_cterm04 = "12"
  let s:cterm06        = "13"
  let g:base16_cterm06 = "13"
  let s:cterm09        = "09"
  let g:base16_cterm09 = "09"
  let s:cterm0F        = "14"
  let g:base16_cterm0F = "14"
endif

" Neovim terminal colours
if has("nvim")
  let g:terminal_color_0 =  "#f8f8f8"
  let g:terminal_color_1 =  "#ab4642"
  let g:terminal_color_2 =  "#a1b56c"
  let g:terminal_color_3 =  "#f7ca88"
  let g:terminal_color_4 =  "#7cafc2"
  let g:terminal_color_5 =  "#ba8baf"
  let g:terminal_color_6 =  "#86c1b9"
  let g:terminal_color_7 =  "#383838"
  let g:terminal_color_8 =  "#b8b8b8"
  let g:terminal_color_9 =  "#ab4642"
  let g:terminal_color_10 = "#a1b56c"
  let g:terminal_color_11 = "#f7ca88"
  let g:terminal_color_12 = "#7cafc2"
  let g:terminal_color_13 = "#ba8baf"
  let g:terminal_color_14 = "#86c1b9"
  let g:terminal_color_15 = "#181818"
  let g:terminal_color_background = g:terminal_color_0
  let g:terminal_color_foreground = g:terminal_color_5
  if &background == "light"
    let g:terminal_color_background = g:terminal_color_7
    let g:terminal_color_foreground = g:terminal_color_2
  endif
endif

" Theme setup
hi clear
syntax reset
let g:colors_name = "espresso"

" Highlighting function
function! g:Base16hi(group, guifg, guibg, ctermfg, ctermbg, attr, guisp)
  if a:guifg != ""
    exec "hi " . a:group . " guifg=#" . a:guifg
  endif
  if a:guibg != ""
    exec "hi " . a:group . " guibg=#" . a:guibg
  endif
  if a:ctermfg != ""
    exec "hi " . a:group . " ctermfg=" . a:ctermfg
  endif
  if a:ctermbg != ""
    exec "hi " . a:group . " ctermbg=" . a:ctermbg
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  endif
  if a:guisp != ""
    exec "hi " . a:group . " guisp=#" . a:guisp
  endif
endfunction


fun <sid>hi(group, guifg, guibg, ctermfg, ctermbg, attr, guisp)
  call g:Base16hi(a:group, a:guifg, a:guibg, a:ctermfg, a:ctermbg, a:attr, a:guisp)
endfun

" Vim editor colors
call <sid>hi("Normal",        s:gui05, s:gui00, s:cterm05, s:cterm00, "", "")
call <sid>hi("Bold",          "", "", "", "", "bold", "")
call <sid>hi("Debug",         s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("Directory",     s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("Error",         s:gui00, s:gui08, s:cterm00, s:cterm08, "", "")
call <sid>hi("ErrorMsg",      s:gui08, s:gui00, s:cterm08, s:cterm00, "", "")
call <sid>hi("Exception",     s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("FoldColumn",    s:gui0C, s:gui01, s:cterm0C, s:cterm01, "", "")
call <sid>hi("Folded",        s:gui03, s:gui01, s:cterm03, s:cterm01, "", "")
call <sid>hi("IncSearch",     s:gui01, s:gui03, s:cterm01, s:cterm03, "none", "")
call <sid>hi("Italic",        "", "", "", "", "none", "")
call <sid>hi("Macro",         s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("MatchParen",    "", s:gui01, "", s:cterm01,  "bold", "")
call <sid>hi("ModeMsg",       s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("MoreMsg",       s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("Question",      s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("Search",        s:gui01, s:gui02, s:cterm01, s:cterm02,  "", "")
call <sid>hi("Substitute",    s:gui01, s:gui02, s:cterm01, s:cterm02, "none", "")
call <sid>hi("SpecialKey",    s:gui03, "", s:cterm03, "", "", "")
call <sid>hi("TooLong",       s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("Underlined",    s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("Visual",        "", s:gui02, "", s:cterm02, "", "")
call <sid>hi("VisualNOS",     s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("WarningMsg",    s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("WildMenu",      s:gui08, s:gui0A, s:cterm08, "", "", "")
call <sid>hi("Title",         s:gui0D, "", s:cterm0D, "", "none", "")
call <sid>hi("Conceal",       s:gui0D, s:gui00, s:cterm0D, s:cterm00, "", "")
call <sid>hi("Cursor",        s:gui00, s:gui05, s:cterm00, s:cterm05, "", "")
call <sid>hi("NonText",       s:gui03, "", s:cterm03, "", "", "")
call <sid>hi("LineNr",        s:gui03, s:gui01, s:cterm03, s:cterm01, "", "")
call <sid>hi("SignColumn",    s:gui03, s:gui01, s:cterm03, s:cterm01, "", "")
call <sid>hi("StatusLine",    s:gui04, s:gui02, s:cterm04, s:cterm02, "none", "")
call <sid>hi("StatusLineNC",  s:gui03, s:gui01, s:cterm03, s:cterm01, "none", "")
call <sid>hi("VertSplit",     s:gui02, s:gui02, s:cterm02, s:cterm02, "none", "")
call <sid>hi("ColorColumn",   "", s:gui01, "", s:cterm01, "none", "")
call <sid>hi("CursorColumn",  "", s:gui01, "", s:cterm01, "none", "")
call <sid>hi("CursorLine",    "", s:gui01, "", s:cterm01, "none", "")
call <sid>hi("CursorLineNr",  s:gui04, s:gui01, s:cterm04, s:cterm01, "", "")
call <sid>hi("QuickFixLine",  "", s:gui01, "", s:cterm01, "none", "")
call <sid>hi("PMenu",         s:gui05, s:gui01, s:cterm05, s:cterm01, "none", "")
call <sid>hi("PMenuSel",      s:gui01, s:gui05, s:cterm01, s:cterm05, "", "")
call <sid>hi("TabLine",       s:gui03, s:gui01, s:cterm03, s:cterm01, "none", "")
call <sid>hi("TabLineFill",   s:gui03, s:gui01, s:cterm03, s:cterm01, "none", "")
call <sid>hi("TabLineSel",    s:gui0B, s:gui01, s:cterm0B, s:cterm01, "none", "")

" Standard syntax highlighting
call <sid>hi("Boolean",      s:gui0E, s:gui06, s:cterm0E, s:cterm06, "", "")
call <sid>hi("Character",    s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("Comment",      s:gui03, "", s:cterm03, "", "", "italic")
call <sid>hi("Conditional",  s:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("Constant",     s:gui09, "", s:cterm09, "", "", "")
call <sid>hi("Define",       s:gui0E, "", s:cterm0E, "", "none", "")
call <sid>hi("Delimiter",    s:gui02, "", s:cterm02, "", "", "")
call <sid>hi("Float",        s:gui09, "", s:cterm09, "", "", "")
call <sid>hi("Function",     s:gui0D, "", s:cterm0D, "", "bold", "")
call <sid>hi("Identifier",   s:gui08, "", s:cterm08, "", "none", "")
call <sid>hi("Include",      s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("Keyword",      s:gui0E, "", s:cterm0E, "", "", "italic")
call <sid>hi("Label",        s:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("Number",       s:gui0E, s:gui06, s:cterm0E, s:cterm06, "", "")
call <sid>hi("Operator",     s:gui05, "", s:cterm05, "", "none", "")
call <sid>hi("PreProc",      s:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("Repeat",       s:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("Special",      s:gui0C, "", s:cterm0C, "", "", "")
call <sid>hi("SpecialChar",  s:gui0F, "", s:cterm0F, "", "", "")
call <sid>hi("Statement",    s:gui0D, "", s:cterm0D, "", "", "italic")
call <sid>hi("StorageClass", s:gui08, "", s:cterm08, "", "bold", "")
call <sid>hi("String",       s:gui0A, s:gui04, s:cterm0A, s:cterm04, "", "")
call <sid>hi("Structure",    s:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("Tag",          s:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("Todo",         s:gui0A, s:gui01, s:cterm0A, s:cterm01, "", "")
call <sid>hi("Type",         s:gui0C, "", s:cterm0C, "", "none", "")
call <sid>hi("Typedef",      s:gui0A, "", s:cterm0A, "", "", "")

" C highlighting
call <sid>hi("cOperator",   s:gui0C, "", s:cterm0C, "", "", "")
call <sid>hi("cPreCondit",  s:gui0E, "", s:cterm0E, "", "", "")

" C# highlighting
call <sid>hi("csClass",                 s:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("csAttribute",             s:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("csModifier",              s:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("csType",                  s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("csUnspecifiedStatement",  s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("csContextualStatement",   s:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("csNewDecleration",        s:gui08, "", s:cterm08, "", "", "")

" CSS highlighting
call <sid>hi("cssBraces",            s:gui05, "", s:cterm05, "", "", "")
call <sid>hi("cssClassName",         s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("cssClassNameDot",      s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("cssIdentifier",        s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("cssVendor",            s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("cssTagName",           s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("cssColor",             s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("cssUnitDecorators",    s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("cssValueLength",       s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("cssValueNumber",       s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("cssValueTime",         s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("cssStringQQ",          s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("cssAttributeSelector", s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("cssFunctionName",      s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("cssBoxAttr",           s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("cssFlexibleBoxAttr",   s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("cssTransitionAttr",    s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("cssAttr",              s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("cssAttrRegion",        s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("cssCommonAttr",        s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("cssBorderAttr",        s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("cssTableAttr",         s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("cssPositioningAttr",   s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("cssPageAttr",          s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("cssMediaAttr",         s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("cssTextAttr",          s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("cssBackgroundAttr",    s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("cssBoxProp",           s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("cssFlexibleBoxProp",   s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("cssTransitionProp",    s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("cssCommonProp",        s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("cssBorderProp",        s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("cssProp",              s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("cssTableProp",         s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("cssPageProp",          s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("cssPositioningProp",   s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("cssMediaProp",         s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("cssKeyframeProp",      s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("cssBackgroundProp",    s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("cssFontProp",          s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("cssTextProp",          s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("cssUIProp",            s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("cssSelectorOp",        s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("cssNoise",             s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("cssPseudoClassId",     s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("cssPseudoClassFn",     s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("cssImportant",         s:gui0E, "", s:cterm0E, "", "bold", "")

" Diff highlighting
call <sid>hi("DiffAdd",      s:gui0B, s:gui01,  s:cterm0B, s:cterm01, "", "")
call <sid>hi("DiffChange",   s:gui03, s:gui01,  s:cterm03, s:cterm01, "", "")
call <sid>hi("DiffDelete",   s:gui08, s:gui01,  s:cterm08, s:cterm01, "", "")
call <sid>hi("DiffText",     s:gui0D, s:gui01,  s:cterm0D, s:cterm01, "", "")
call <sid>hi("DiffAdded",    s:gui0B, s:gui00,  s:cterm0B, s:cterm00, "", "")
call <sid>hi("DiffFile",     s:gui08, s:gui00,  s:cterm08, s:cterm00, "", "")
call <sid>hi("DiffNewFile",  s:gui0B, s:gui00,  s:cterm0B, s:cterm00, "", "")
call <sid>hi("DiffLine",     s:gui0D, s:gui00,  s:cterm0D, s:cterm00, "", "")
call <sid>hi("DiffRemoved",  s:gui08, s:gui00,  s:cterm08, s:cterm00, "", "")

" Git highlighting
call <sid>hi("gitcommitOverflow",       s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("gitcommitSummary",        s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("gitcommitComment",        s:gui03, "", s:cterm03, "", "", "")
call <sid>hi("gitcommitUntracked",      s:gui03, "", s:cterm03, "", "", "")
call <sid>hi("gitcommitDiscarded",      s:gui03, "", s:cterm03, "", "", "")
call <sid>hi("gitcommitSelected",       s:gui03, "", s:cterm03, "", "", "")
call <sid>hi("gitcommitHeader",         s:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("gitcommitSelectedType",   s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("gitcommitUnmergedType",   s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("gitcommitDiscardedType",  s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("gitcommitBranch",         s:gui09, "", s:cterm09, "", "bold", "")
call <sid>hi("gitcommitUntrackedFile",  s:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("gitcommitUnmergedFile",   s:gui08, "", s:cterm08, "", "bold", "")
call <sid>hi("gitcommitDiscardedFile",  s:gui08, "", s:cterm08, "", "bold", "")
call <sid>hi("gitcommitSelectedFile",   s:gui0B, "", s:cterm0B, "", "bold", "")

" GitGutter highlighting
call <sid>hi("GitGutterAdd",     s:gui0B, s:gui01, s:cterm0B, s:cterm01, "", "")
call <sid>hi("GitGutterChange",  s:gui0D, s:gui01, s:cterm0D, s:cterm01, "", "")
call <sid>hi("GitGutterDelete",  s:gui08, s:gui01, s:cterm08, s:cterm01, "", "")
call <sid>hi("GitGutterChangeDelete",  s:gui0E, s:gui01, s:cterm0E, s:cterm01, "", "")

" HTML highlighting
call <sid>hi("htmlBold",           s:gui07, "", s:cterm07, "", "", "")
call <sid>hi("htmlItalic",         s:gui07, "", s:cterm07, "", "", "")
call <sid>hi("htmlEndTag",         s:gui0C, "", s:cterm0C, "", "", "")
call <sid>hi("htmlTag",            s:gui0C, "", s:cterm0C, "", "", "")
call <sid>hi("htmlTagN",           s:gui0D, s:gui01, s:cterm0D, s:cterm01, "", "")
call <sid>hi("htmlTagName",        s:gui0D, s:gui01, s:cterm0D, s:cterm01, "", "")
call <sid>hi("htmlSpecialTagName", s:gui0D, s:gui01, s:cterm0D, s:cterm01, "bold", "")
call <sid>hi("htmlString",         s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("htmlLink",           s:gui07, "", s:cterm07, "", "", "")
call <sid>hi("htmlArg",            s:gui0D, "", s:cterm0D, "", "", "")

" JavaScript highlighting
call <sid>hi("javaScript",        s:gui05, "", s:cterm05, "", "", "")
call <sid>hi("javaScriptBraces",  s:gui05, "", s:cterm05, "", "", "")
call <sid>hi("javaScriptNumber",  s:gui09, "", s:cterm09, "", "", "")

" pangloss/vim-javascript highlighting
call <sid>hi("jsOperator",          s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("jsStatement",         s:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("jsReturn",            s:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("jsThis",              s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("jsExport",            s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("jsClassDefinition",   s:gui0A, "", s:cterm0A, "", "bold", "")
call <sid>hi("jsFunction",          s:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("jsArrowFunction",     s:gui0E, "", s:cterm0E, "", "bold", "")
call <sid>hi("jsFuncName",          s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("jsFuncCall",          s:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("jsClassFuncName",     s:gui0D, "", s:cterm0D, "", "bold", "")
call <sid>hi("jsFuncParens",        s:gui0D, "", s:cterm0D, "", "bold", "")
call <sid>hi("jsClassMethodType",   s:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("jsRegexpString",      s:gui0C, "", s:cterm0C, "", "", "")
call <sid>hi("jsGlobalObjects",     s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("jsStorageClass",      s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("jsObjectKey",         s:gui05, "", s:cterm05, "", "", "")
call <sid>hi("jsGlobalNodeObjects", s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("jsExceptions",        s:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("jsBuiltins",          s:gui0A, "", s:cterm0A, "", "", "")

" Mail highlighting
call <sid>hi("mailQuoted1",  s:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("mailQuoted2",  s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("mailQuoted3",  s:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("mailQuoted4",  s:gui0C, "", s:cterm0C, "", "", "")
call <sid>hi("mailQuoted5",  s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("mailQuoted6",  s:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("mailURL",      s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("mailEmail",    s:gui0D, "", s:cterm0D, "", "", "")

" Markdown highlighting
call <sid>hi("markdownCode",              s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("markdownError",             s:gui05, s:gui00, s:cterm05, s:cterm00, "", "")
call <sid>hi("markdownCodeBlock",         s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("markdownHeadingDelimiter",  s:gui0D, "", s:cterm0D, "", "", "")

" NERDTree highlighting
call <sid>hi("NERDTreeDirSlash",  s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("NERDTreeExecFile",  s:gui05, "", s:cterm05, "", "", "")

" PHP highlighting
call <sid>hi("phpMemberSelector",  s:gui05, "", s:cterm05, "", "", "")
call <sid>hi("phpComparison",      s:gui05, "", s:cterm05, "", "", "")
call <sid>hi("phpParent",          s:gui05, "", s:cterm05, "", "", "")
call <sid>hi("phpType",            s:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("phpIdentifier",      s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("phpVarSelector",     s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("phpThis",            s:gui0D, "", s:cterm0D, "", "", "italic")
call <sid>hi("phpFunction",        s:gui0D, "", s:cterm0D, "", "bold", "")
call <sid>hi("phpMethod",          s:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("phpClass",           s:gui0A, "", s:cterm0A, "", "bold", "")
call <sid>hi("phpStaticClasses",   s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("phpFunctions",       s:gui08, "", s:cterm08, "", "bold", "")

" Python highlighting
call <sid>hi("pythonOperator",  s:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("pythonRepeat",    s:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("pythonInclude",   s:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("pythonStatement", s:gui0E, "", s:cterm0E, "", "", "")

" Ruby highlighting
call <sid>hi("rubyAttribute",               s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("rubyConstant",                s:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("rubyInterpolationDelimiter",  s:gui0F, "", s:cterm0F, "", "", "")
call <sid>hi("rubyRegexp",                  s:gui0C, "", s:cterm0C, "", "", "")
call <sid>hi("rubySymbol",                  s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("rubyStringDelimiter",         s:gui0B, "", s:cterm0B, "", "", "")

" SASS highlighting
call <sid>hi("sassidChar",       s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("sassClassChar",    s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("sassInclude",      s:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("sassVariable",     s:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("sassMixing",       s:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("sassMixinName",    s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("sassCssAttribute", s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("sassAmpersand",    s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("sassClass",        s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("sassProperty",     s:gui08, "", s:cterm08, "", "", "")
call <sid>hi("sassId",           s:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("sassidChar",       s:gui0D, "", s:cterm0D, "", "", "")


" Signify highlighting
call <sid>hi("SignifySignAdd",     s:gui0B, s:gui01, s:cterm0B, s:cterm01, "", "")
call <sid>hi("SignifySignChange",  s:gui0D, s:gui01, s:cterm0D, s:cterm01, "", "")
call <sid>hi("SignifySignDelete",  s:gui08, s:gui01, s:cterm08, s:cterm01, "", "")

" Spelling highlighting
call <sid>hi("SpellBad",     "", "", "", "", "undercurl", s:gui08)
call <sid>hi("SpellLocal",   "", "", "", "", "undercurl", s:gui0C)
call <sid>hi("SpellCap",     "", "", "", "", "undercurl", s:gui0D)
call <sid>hi("SpellRare",    "", "", "", "", "undercurl", s:gui0E)

" Startify highlighting
call <sid>hi("StartifyBracket",  s:gui03, "", s:cterm03, "", "", "")
call <sid>hi("StartifyFile",     s:gui07, "", s:cterm07, "", "", "")
call <sid>hi("StartifyFooter",   s:gui03, "", s:cterm03, "", "", "")
call <sid>hi("StartifyHeader",   s:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("StartifyNumber",   s:gui09, "", s:cterm09, "", "", "")
call <sid>hi("StartifyPath",     s:gui03, "", s:cterm03, "", "", "")
call <sid>hi("StartifySection",  s:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("StartifySelect",   s:gui0C, "", s:cterm0C, "", "", "")
call <sid>hi("StartifySlash",    s:gui03, "", s:cterm03, "", "", "")
call <sid>hi("StartifySpecial",  s:gui03, "", s:cterm03, "", "", "")

" Java highlighting
call <sid>hi("javaOperator",     s:gui0D, "", s:cterm0D, "", "", "")

" Remove functions
delf <sid>hi

" Other Stuff
hi link CtrlSpaceNormal CursorLine
hi link CtrlSpaceSelected StatusLine
hi link CtrlSpaceStatus Ctrlpdark

" Remove color variables
unlet s:gui00 s:gui01 s:gui02 s:gui03  s:gui04  s:gui05  s:gui06  s:gui07  s:gui08  s:gui09 s:gui0A  s:gui0B  s:gui0C  s:gui0D  s:gui0E  s:gui0F
unlet s:cterm00 s:cterm01 s:cterm02 s:cterm03 s:cterm04 s:cterm05 s:cterm06 s:cterm07 s:cterm08 s:cterm09 s:cterm0A s:cterm0B s:cterm0C s:cterm0D s:cterm0E s:cterm0F
