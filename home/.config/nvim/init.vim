" General settings {{{
syntax enable
filetype plugin indent on
set nofoldenable

set foldmethod=syntax

set number relativenumber
set scrolloff=10
set cursorline

set fillchars+=vert:\│

"}}}

" Indenting {{{
set encoding=utf-8
set autoindent
set copyindent
set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=0
set smarttab
"}}}

" Functions {{{
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
" }}}

" Commands {{{
command! TrimWhitespace call TrimWhitespace()
" }}}

" Plug {{{
" THIS IS FOR PLUGGED PLUGINS
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes

Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lervag/vimtex'
" Use release branch
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'posva/vim-vue'
Plug 'vim-python/python-syntax'
Plug 'majutsushi/tagbar'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-surround'
"Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'rust-lang/rust.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tridactyl/vim-tridactyl'
Plug 'tommcdo/vim-lion'
Plug 'machakann/vim-highlightedyank'
Plug 'frazrepo/vim-rainbow'
Plug 'kshenoy/vim-signature'
Plug 'eugen0329/vim-esearch'

" Initialize plugin system
call plug#end()
"}}}

" Statusline {{{
set statusline+=%{fugitive#statusline()}
"set statusline^=${coc#status()}

set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#alt_sep = 1
let g:airline#extensions#lsp#enabled = 1
"lsp show_line_numbers
let airline#extensions#lsp#show_line_numbers = 1
" lsp error_symbol
let airline#extensions#lsp#error_symbol = 'E:'
" lsp warning
let airline#extensions#lsp#warning_symbol = 'W:'
let g:airline_theme = 'base16'

if !exists('g:airline_symbols')
	    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.dirty='⚡'
"}}}

" C syntax plugin {{{
let c_c_vim_compatible = 1
let c_gnu = 1
let c_cpp_comments = 1
let c_comment_strings = 1
let c_comment_numbers = 1
let c_comment_types = 1
let c_ansi_typedefs = 1
let c_ansi_constants = 1
let c_posix = 1
let c_C99 = 1
"}}}

" C++ syntax plugin {{{
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
let c_no_curly_error = 1
"}}}

"Language supports {{{

"CUDA support
au BufNewFile,BufRead *.cu set ft=cpp

"OpenCL support
au BufNewFile,BufRead *.cl set ft=opencl

"Jump to first non-empty line for mails
au FileType mail execute "normal }"
"}}}

"LaTeX-Suite {{{
filetype plugin on
let g:tex_flavor = 'latex'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_latexmk = {
	\ 'build_dir' : './build'
	\}
"}}}

" Key bindings {{{
nmap <leader>cl :set cursorline!<cr>
nnoremap <leader>m :w<cr> :silent make\|redraw!\|cw<cr>
nmap <leader>nn :NERDTreeToggle<cr>
nmap <leader>lb :set colorcolumn=80<cr>
nmap <leader>ig :set list!<cr>
nmap <leader>tg :TagbarToggle<cr>
noremap <leader>w :call TrimWhitespace()<cr>

nmap <C-u> :redo<CR>

" GitGutter
let g:gitgutter_enabled = 0
nmap <leader>gg :GitGutterToggle<CR>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
" Show buffer menu
nnoremap <C-z> :FZF<CR>
nnoremap <C-p> :Buffer<CR>

nnoremap <esc> :noh<CR>

nn <silent> <M-d> :LspDefinition<cr>
nn <silent> <M-r> :LspReferences<cr>
nn <silent> <M-=> :LspDocumentFormat<cr>
nn <f2> :LspRename<cr>

" Enable ag search
nnoremap <silent> <Leader>a :Ag <C-R><C-W><CR>

"}}}

" FZF {{{
let g:fzf_layout = {'down': '~20%'}
let g:fzf_action = {
	\ 'ctrl-t': 'tab split',
	\ 'ctrl-s': 'split',
	\ 'ctrl-v': 'vsplit' }
"}}}

" LSP Settings {{{
let g:lsp_diagnostics_echo_cursor=1
let g:lsp_highlight_references_enabled=1
let g:lsp_signs_enabled=1
let g:lsp_text_edit_enabled=0
let g:lsp_virtual_text_prefix = " ‣ "

let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'test': ''}
let g:lsp_signs_hint = {'text': ''}

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> <Leader>gd <plug>(lsp-definition)
    nmap <buffer> <Leader>gr <plug>(lsp-references)
    nmap <buffer> <Leader>gi <plug>(lsp-implementation)
    nmap <buffer> <Leader>gt <plug>(lsp-type-definition)
    nmap <buffer> <Leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
    nmap <buffer> <Leader>lh <plug>(lsp-hover)
    nmap <buffer> <Leader>lf <plug>(lsp-document-format)

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'priority': -1,
    \ }))
" File & directory names
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'priority': 0,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))

" Rust autocompletion (requires "Racer")
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#racer#get_source_options())

" C/C++ LSP
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
		\ 'priority' : 10
        \ })
endif
" Rust
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
        \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
        \ 'whitelist': ['rust'],
        \ })
endif
" }}}

" CoC Settings {{{
" clangd {{{
" }}}

" VIM rainbow {{{
let g:rainbow_active = 1
"let g:rainbow_ctermfgs = ['#66cccc', '#6699cc', '#f99157', '#cc99cc', '#ffcc66']
let g:rainbow_guifgs = ['#66cccc', '#6699cc', '#f99157', '#cc99cc', '#99cc99', '#ffcc66']
let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]
" }}}

" Colorscheme {{{
let base16colorspace=256
set termguicolors
colorscheme base16-tomorrow-night-eighties
"}}}

" Colorizer LUA {{{
lua require'colorizer'.setup()
" }}}

" Directory specific settings {{{
" if a .vimlocal is found in dir, load it
" else ignore
silent! so .vimlocal
"}}}
" vim: fdm=marker
