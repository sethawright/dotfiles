let g:airline#themes#materitermdark#palette = {}

let s:N1 = [ '#3c4c54' , '#eeffff' , 'black' , 15      ]
let s:N2 = [ '#eeffff' , '#566f7c' , 15      , 8       ]
let s:N3 = [ '#ffffff' , '#3c4c54' , 255     , 'black' ]
let g:airline#themes#materitermdark#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#materitermdark#palette.normal.airline_a = ['#3c4c54', '#c3e88d', 21, 10, '']

let g:airline#themes#materitermdark#palette.insert = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#materitermdark#palette.insert.airline_a = ['#ffffff', '#c792ea', 21, 5]

let g:airline#themes#materitermdark#palette.replace = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#materitermdark#palette.replace.airline_a = ['#3c4c54', '#ff5370', 21, 9]

let g:airline#themes#materitermdark#palette.visual = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#materitermdark#palette.visual.airline_a = ['#ffffff', '#f78c6c', 21, 17]

let s:IA1 = [ '#3c4c54' , '#2c3b42' , 7 , 21 , '' ]
let s:IA2 = [ '#3c4c54' , '#2c3b42' , 7 , 21 , '' ]
let s:IA3 = [ '#3c4c54' , '#2c3b42' , 7 , 21 , '' ]
let g:airline#themes#materitermdark#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)

let g:airline#themes#materitermdark#palette.accents = {
      \ 'red': [ '#ff0000' , '' , 160 , ''  ]
      \ }
