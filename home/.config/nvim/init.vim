" General settings {{{
syntax enable
filetype plugin indent on
set nofoldenable

set foldmethod=syntax

set number relativenumber
set scrolloff=10
set cursorline

set undofile

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

" Use release branch
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'chriskempson/base16-vim'
Plug 'pboettch/vim-cmake-syntax'
Plug 'eugen0329/vim-esearch'
Plug 'frazrepo/vim-rainbow'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'kshenoy/vim-signature'
Plug 'lervag/vimtex'
Plug 'machakann/vim-highlightedyank'
Plug 'majutsushi/tagbar'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tridactyl/vim-tridactyl'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-python/python-syntax'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/completion-treesitter'
Plug 'kabouzeid/nvim-lspinstall'

" Initialize plugin system
call plug#end()
" }}}

" Colorscheme {{{
let base16colorspace=256
set termguicolors
colorscheme base16-tomorrow-night-eighties
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
let airline#extensions#lsp#error_symbol = '✗:'
" lsp warning
let airline#extensions#lsp#warning_symbol = ':'
let g:airline_theme = 'base16'

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰ '
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'
"}}}

" Python semantic plugin {{{
let g:semshi#error_sign = v:false
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

" map space to mapleader
nnoremap <space> <nop>
let mapleader = " "

nmap <leader>cl :set cursorline!<cr>
nnoremap <leader>m :w<cr> :silent make\|redraw!\|cw<cr>
nmap <leader>nn :NERDTreeToggle<cr>
nmap <leader>lb :set colorcolumn=80<cr>
nmap <leader>ig :set list!<cr>
nmap <leader>tg :TagbarToggle<cr>
noremap <leader>w :call TrimWhitespace()<cr>
" fucking word sorting!
vnoremap <leader>s d:execute 'normal i' . join(sort(split(getreg('"'))), ' ')<CR>

nmap <C-u> :redo<CR>

" GitGutter
let g:gitgutter_enabled = 0
nmap <leader>gg :GitGutterToggle<CR>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Show buffer menu
nnoremap <C-z> :FZF<CR>
nnoremap <C-p> :Buffer<CR>

nnoremap <esc> :noh<CR>

"}}}

" FZF {{{
let g:fzf_layout = {'down': '~20%'}
let g:fzf_action = {
	\ 'ctrl-t': 'tab split',
	\ 'ctrl-s': 'split',
	\ 'ctrl-v': 'vsplit' }
"}}}

" LSP Settings {{{

lua require("lsp_config")

" Keymaps
nnoremap <silent> <Leader>gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <Leader>gD <cmd>leftabove vim.lsp.buf.definition()<CR>
nnoremap <silent> <Leader>gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <Leader>gI <cmd>leftabove lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <Leader>gc <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <Leader>gC <cmd>leftabove lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <Leader>gt <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <leader>gT <cmd>leftabove lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <Leader>gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <Leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <Leader>lh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <Leader>ls <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <Leader>lf <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <Leader>ld <cmd>lua vim.lsp.buf.diagnostics.get_all()<CR>
nnoremap <silent> ]g <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> [g <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>

"  Colours
hi LspDiagnosticsSignWarning     gui=NONE guifg=#f99157 guibg=#393939
hi LspDiagnosticsSignError       gui=bold guifg=#f2777a guibg=#393939
hi LspDiagnosticsSignInformation gui=NONE guifg=#ffcc66 guibg=#393939
hi LspDiagnosticsSignHint        gui=NONE guifg=#999999 guibg=#393939

sign define LspDiagnosticsSignError       text=✗ texthl=LspDiagnosticsSignError       linehl= numhl=
sign define LspDiagnosticsSignWarning     text= texthl=LspDiagnosticsSignWarning     linehl= numhl=
sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint        text=H texthl=LspDiagnosticsSignHint        linehl= numhl=

" Completion
set completeopt=menuone,noinsert,noselect
let g:completion_chain_complete_list = {
	\'default' : {
	\		'default' : [
	\			{'complete_items' : ['lsp', 'snippet']},
	\		],
	\},
	\'vim' : [
	\	{'complete_items': ['snippet']}
	\],
	\'c' : [
	\	{'complete_items': ['ts', 'lsp']}
	\],
	\'cpp' : [
	\	{'complete_items': ['ts', 'lsp']}
	\],
	\'lua' : [
	\	{'complete_items': ['ts', 'lsp']}
	\],
	\'rust' : [
	\	{'complete_items': ['ts', 'lsp']}
	\],
	\'python' : [
	\	{'complete_items': ['ts', 'lsp']}
	\],
	\}
" }}}

" {{{ Treesitter

lua require("treesitter_config")

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

" Colorizer LUA {{{
lua require'colorizer'.setup()
" }}}

" Directory specific settings {{{
" if a .vimlocal is found in dir, load it
" else ignore
silent! so .vimlocal
"}}}
" vim: fdm=marker
