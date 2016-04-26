syntax enable
execute pathogen#infect()
filetype plugin indent on

"============================================================
"Language supports

"CUDA support
au BufNewFile,BufRead *.cu set ft=cpp

"OpenCL support
au BufNewFile,BufRead *.cl set ft=opencl

"============================================================
"youcompleteme
"let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
"Airline enable
set laststatus=2
"let g:molokai_original = 1
let g:rehash256 = 1

"LaTeX-Suite
filetype plugin on
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'


if has('gui_running')
    "GVIM
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
    colorscheme molokai 
    set backspace=indent,eol,start
    set completefunc=youcompleteme#Complete
    set completeopt=preview,menuone
    set cpoptions=aAceFsB
    set expandtab
    set fileencodings=ucs-bom,utf-8,default,latin1
    set guifont=DejaVu\ Sans\ Mono\ 10
    set guioptions=aegimrLt
    set guioptions-=m
    set helplang=en
    set cursorline
    set colorcolumn=80
    hi ColorColumn guibg=darkgrey
    set number
    set mouse=a
    set ruler
    set shiftwidth=4
    set shortmess=filnxtToOc
    set softtabstop=4
    set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.png,.jpg
    set tabstop=4
    set termencoding=utf-8
    set updatetime=2000
    set window=55
    " vim: set ft=vim :
else
    set t_Co=256
    colorscheme molokai 
    set colorcolumn=80
    hi ColorColumn ctermbg=darkgrey

    nmap <leader>c :w<cr>:silent call Tex_RunLaTeX()<cr>
    set number
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set expandtab
endif
