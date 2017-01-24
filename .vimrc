syntax enable
execute pathogen#infect()
filetype plugin indent on
set encoding=utf-8
"Settings for vim and gvim
set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab

"Plugin settings
"------------------------------------------------
"fugative settings
set statusline+=%{fugitive#statusline()}

"syntastic settings
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_c_gcc_args = "-Wall -Werror -pedantic-errors"

let g:syntastic_mode_map = { 'passive_filetypes': ['tex'] }


let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"youcompleteme
"let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_filetype_whitelist = {'cpp' : 1}

"Airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'badwolf'

if !exists('g:airline_symbols')
	    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = ''
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = ''
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
  
" airline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''

"let g:molokai_original = 1
let g:rehash256 = 1


"============================================================
"Language supports

"CUDA support
au BufNewFile,BufRead *.cu set ft=cpp

"OpenCL support
au BufNewFile,BufRead *.cl set ft=opencl

"============================================================

"LaTeX-Suite
filetype plugin on
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
au BufNewFile,BufRead *.tex set colorcolumn=80
au BufNewFile,BufRead *.tex set shiftwidth=2
au BufNewFile,BufRead *.tex set tabstop=2
au BufNewFile,BufRead *.tex set softtabstop=2
hi ColorColumn ctermbg=darkgrey

nmap <leader>cl :set cursorline!<cr>
nmap <leader>cc :w<cr>:silent call Tex_RunLaTeX()<cr>
nnoremap <leader>m :w<cr> :silent make\|redraw!\|cw<cr>
nmap <leader>nn :NERDTreeToggle<cr>
nmap <leader>lb :set colorcolumn=80<cr>


if has('gui_running')
    "GVIM
    set guifont=Droid\ Sans\ Mono\ Slashed\ for\ Powerline
    version 6.0
    if &cp | set nocp | endif
    let s:cpo_save=&cpo
    set cpo&vim
    "inoremap <C-Space> 
    imap <Nul> <C-Space>
    "inoremap <expr> <Up> pumvisible() ? "\" : "\<Up>"
    inoremap <expr> <S-Tab> pumvisible() ? "\" : "\<S-Tab>"
    "inoremap <expr> <Down> pumvisible() ? "\" : "\<Down>"
    imap <F5> <Plug>ToggleBackground
    map! <S-Insert> <MiddleMouse>
    nnoremap \d :YcmShowDetailedDiagnostic
    vmap gx <Plug>NetrwBrowseXVis
    nmap gx <Plug>NetrwBrowseX
    vnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
    nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(expand((exists("g:netrw_gx")? g:netrw_gx : '<cfile>')),netrw#CheckIfRemote())
    vmap <F5> <Plug>ToggleBackground
    nmap <F5> <Plug>ToggleBackground
    map <S-Insert> <MiddleMouse>
    inoremap <expr>      pumvisible() ? "\" : "\    "
    let &cpo=s:cpo_save
    unlet s:cpo_save
    hi iCursor guifg=white guibg=black
    set guicursor=n-v-c:block-Cursor
    set guicursor=n-v-c:blinkon0
    set guicursor+=i:ver100-iCursor
    colorscheme molokai 
    set backspace=indent,eol,start
    set completefunc=youcompleteme#Complete
    set completeopt=preview,menuone
    set cpoptions=aAceFsB
    set noexpandtab
    set fileencodings=ucs-bom,utf-8,default,latin1
    set guifont=DejaVu\ Sans\ Mono\ 10
    set guioptions=aegimrLt
    set guioptions-=m
    set helplang=en
    set cursorline
    set number
    set mouse=a
    set ruler
    set shortmess=filnxtToOc
    set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.png,.jpg
    set termencoding=utf-8
    set updatetime=2000
    set window=55
    " vim: set ft=vim :
else
    set t_Co=256
    colorscheme molokai
    
    set number
endif
