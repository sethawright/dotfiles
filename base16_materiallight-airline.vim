let g:airline#themes#base16_materiallight#palette = {}

let s:N1 = [ '#b0bec5' , '#3c4c54' , 'black' , 15      ]
let s:N2 = [ '#3c4c54' , '#7e939e' , 15      , 8       ]
let s:N3 = [ '#ffffff' , '#b0bec5' , 255     , 'black' ]
let g:airline#themes#base16_materiallight#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#base16_materiallight#palette.normal.airline_a = ['#e5e9ea', '#40a33f', 21, 10, '']

let g:airline#themes#base16_materiallight#palette.insert = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#base16_materiallight#palette.insert.airline_a = ['#e5e9ea', '#992bae', 21, 5]

let g:airline#themes#base16_materiallight#palette.replace = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#base16_materiallight#palette.replace.airline_a = ['#e5e9ea', '#e83b3f', 21, 9]

let g:airline#themes#base16_materiallight#palette.visual = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#base16_materiallight#palette.visual.airline_a = ['#e5e9ea', '#f78c6c', 21, 17]

let s:IA1 = [ '#c4cfd4' , '#e5e9ea' , 7 , 21 , '' ]
let s:IA2 = [ '#c4cfd4' , '#e5e9ea' , 7 , 21 , '' ]
let s:IA3 = [ '#c4cfd4' , '#e5e9ea' , 7 , 21 , '' ]
let g:airline#themes#base16_materiallight#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)

let g:airline#themes#base16_materiallight#palette.accents = {
      \ 'red': [ '#ff0000' , '' , 160 , ''  ]
      \ }