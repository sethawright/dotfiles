""
" Toggle terminal buffer or create new one if there is none.
"
" nnoremap <silent> <C-z> :call kutsan#mappings#toggleterminal()<Enter>
" tnoremap <silent> <C-z> <C-\><C-n>:call kutsan#mappings#toggleterminal()<Enter>
""

autocmd BufEnter term://* startinsert
autocmd BufEnter term://* execute seth#terminal#update()

function! seth#terminal#toggle() abort
	if !has('nvim')
		return v:false
	endif

	if !exists('g:terminal')
		let g:terminal = {
			\ 'tabnr': v:null,
			\ 'loaded': v:null,
			\ 'termbufferid': v:null,
			\ 'originbufferid': v:null
		\ }
	endif

	function! g:terminal.on_exit(jobid, data, event)
		let g:terminal = {
			\ 'tabnr': v:null,
			\ 'loaded': v:null,
			\ 'termbufferid': v:null,
			\ 'originbufferid': v:null
		\ }
	endfunction

	" Create terminal and finish.
	if !g:terminal.loaded
			let g:terminal.originbufferid = bufnr('')
	    call seth#terminal#create()
	    return v:true
	endif

	" Go back to origin buffer if current buffer is terminal.
	if g:terminal.tabnr ==# tabpagenr()
		silent execute 'sbuf' g:terminal.originbufferid
	" Launch terminal buffer and start insert mode.
	else
			let g:terminal.originbufferid = bufnr('')
			silent execute 'sbuf' g:terminal.termbufferid
	    startinsert
	endif
endfunction

function! seth#terminal#create() abort
	if !exists('g:terminal')
		call seth#terminal#toggle()
		return v:true
	endif

	if !g:terminal.tabnr
	    tabnew
	    let g:terminal.tabnr = tabpagenr()
	endif

	enew | call termopen(&shell, g:terminal)
	let g:terminal.termbufferid = bufnr('')
	let g:terminal.loaded = v:true
	setlocal nonumber norelativenumber
	startinsert
	return v:true
endfunction

function seth#terminal#update()
	let g:terminal.termbufferid = bufnr('')
	let g:terminal.loaded = v:true
endfunction
