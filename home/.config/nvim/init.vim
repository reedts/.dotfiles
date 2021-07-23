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

" Navigation
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'eugen0329/vim-esearch'
Plug 'majutsushi/tagbar'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall', {'branch': 'main'}
Plug 'nvim-lua/completion-nvim'
Plug 'lervag/vimtex'

" Treesitter
Plug 'nvim-treesitter/completion-treesitter'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'kyazdani42/nvim-web-devicons'				" for symbols

" Languages
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'pboettch/vim-cmake-syntax'
Plug 'rust-lang/rust.vim'
Plug 'tridactyl/vim-tridactyl'
Plug 'vim-python/python-syntax'

" Pope
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Utils
Plug 'airblade/vim-gitgutter'
Plug 'chriskempson/base16-vim'
Plug 'frazrepo/vim-rainbow'
Plug 'kshenoy/vim-signature'
Plug 'machakann/vim-highlightedyank'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'tommcdo/vim-lion'
Plug 'Yggdroot/indentLine'

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

set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#alt_sep = 1
let g:airline#extensions#nvimlsp#enabled = 1
let g:airline#extensions#scrollbar#enabled = 0

"lsp show_line_numbers
let airline#extensions#nvimlsp#show_line_numbers = 1
" lsp error_symbol
let airline#extensions#nvimlsp#error_symbol = '✗:'
" lsp warning
let airline#extensions#nvimlsp#warning_symbol = ':'

let g:airline_theme = 'base16'

let g:airline_powerline_fonts = 1

" overwriting some symbols
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_symbols.branch = ''
let g:airline_symbols.dirty = ' '

" }}}

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

nmap     <leader>nn <cmd>NERDTreeToggle<cr>
nmap     <leader>tg <cmd>TagbarToggle<cr>
nmap 	 <leader>ee <plug>(esearch)
noremap  <leader>w  <cmd>call TrimWhitespace()<cr>
" fucking word sorting!
vnoremap <leader>s  d:execute 'normal i' . join(sort(split(getreg('"'))), ' ')<CR>

nmap <C-u> :redo<CR>

" GitGutter
let g:gitgutter_enabled = 0
nmap <leader>gg :GitGutterToggle<CR>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <silent> <esc> :noh<CR>

"}}}

" LSP Settings {{{

lua require("lsp_config")

" Keymaps
nnoremap <silent> <Leader>gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <Leader>gD <cmd>leftabove lua vim.lsp.buf.definition()<CR>
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
nnoremap <silent> <Leader>ld <cmd>lua vim.lsp.diagnostic.get_all()<CR>
nnoremap <silent> <Leader>ls <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

nnoremap <silent> ]g <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> [g <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>

" Colour
hi! link LspDiagnosticsDefaultError       ErrorMsg
hi       LspDiagnosticsDefaultWarning     gui=NONE   guifg=#f99157
hi       LspDiagnosticsDefaultInformation gui=italic guifg=#ffcc66
hi       LspdiagnosticsDefaultHint        gui=italic guifg=#999999

hi LspDiagnosticsUnderlineInformation cterm=NONE gui=NONE
hi LspDiagnosticsUnderlineHint        cterm=NONE gui=NONE

hi LspDiagnosticsSignWarning     gui=NONE guifg=#f99157 guibg=#393939
hi LspDiagnosticsSignError       gui=bold guifg=#f2777a guibg=#393939
hi LspDiagnosticsSignInformation gui=NONE guifg=#ffcc66 guibg=#393939
hi LspDiagnosticsSignHint        gui=NONE guifg=#999999 guibg=#393939

sign define LspDiagnosticsSignError       text=✗ texthl=LspDiagnosticsSignError       linehl= numhl=
sign define LspDiagnosticsSignWarning     text= texthl=LspDiagnosticsSignWarning     linehl= numhl=
sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint        text= texthl=LspDiagnosticsSignHint        linehl= numhl=

" Completion
autocmd BufEnter * lua require'completion'.on_attach()

set completeopt=menuone,noinsert,noselect
let g:completion_chain_complete_list = {
	\'default' : {
	\		'default' : [
	\			{'complete_items' : ['path']},
	\			{'complete_items' : ['ts']},
	\			{'complete_items' : ['lsp', 'snippet']},
	\			{'mode': '<c-p>'},
	\			{'mode': '<c-n>'}
	\		],
	\},
	\'TelescopePrompt' : []
\}

let g:completion_auto_change_source = 1
imap <c-j> <plug>(completion_next_source)
imap <c-k> <plug>(completion_prev_source)
" }}}

" {{{ Treesitter

lua require("treesitter_config")

" }}}

" {{{ Telescope

lua require("telescope_config")

nnoremap <silent> <leader>ff <cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <silent> <leader>fi <cmd>lua require('telescope.builtin').git_files()<CR>
nnoremap <silent> <leader>fg <cmd>lua require('telescope.builtin').grep_string()<CR>
nnoremap <silent> <leader>fl <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <silent> <leader>fb <cmd>lua require('telescope.builtin').buffers({ show_all_buffers = true })<CR>

" lsp specific
nnoremap <silent> <leader>flr <cmd>lua require('telescope.builtin').lsp_references()<CR>
nnoremap <silent> <leader>fls <cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>
nnoremap <silent> <leader>flS <cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>
nnoremap <silent> <leader>fla <cmd>lua require('telescope.builtin').lsp_code_actions()<CR>
nnoremap <silent> <leader>flA <cmd>lua require('telescope.builtin').lsp_range_code_actions()<CR>
nnoremap <silent> <leader>fle <cmd>lua require('telescope.builtin').lsp_document_diagnostics()<CR>
nnoremap <silent> <leader>flE <cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<CR>
nnoremap <silent> <leader>fld <cmd>lua require('telescope.builtin').lsp_definitions()<CR>

" custom searches
nnoremap <silent> <leader>fhs <cmd>lua require('telescope_config').search_dotfiles()<CR>
nnoremap <silent> <leader>fcf <cmd>lua require('telescope_config').search_config()<CR>

" }}}

" VIM rainbow {{{
let g:rainbow_active = 1
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

" {{{ IndentLines

let g:indentLine_color_gui = '#515151'

let g:indentLine_char_list = ['┆']
" }}}

" Directory specific settings {{{
" if a .vimlocal is found in dir, load it
" else ignore
silent! so .vimlocal
"}}}
" vim: fdm=marker
