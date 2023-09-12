" General settings {{{
syntax enable
filetype plugin indent on
set nofoldenable

set foldmethod=syntax

set number relativenumber
set scrolloff=10
set cursorline
set cmdheight=0

set undofile

set fillchars+=vert:\│

"}}}

" Indenting {{{
set encoding=utf-8
set autoindent
set copyindent
set tabstop=4
set shiftwidth=4
set softtabstop=0
"}}}

" Commands {{{

"Jump to first non-empty line for mails
au FileType mail execute "normal }"
" }}}

" Plug {{{
" THIS IS FOR PLUGGED PLUGINS
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes

" Navigation
Plug 'eugen0329/vim-esearch'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim', {'branch': 'main'}
Plug 'williamboman/mason-lspconfig.nvim', {'branch': 'main'}
Plug 'jose-elias-alvarez/null-ls.nvim', {'branch': 'main'}
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'hrsh7th/cmp-path', {'branch': 'main'}
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'hrsh7th/cmp-nvim-lsp-signature-help', {'branch': 'main'}
Plug 'onsails/lspkind-nvim'
Plug 'lervag/vimtex'
Plug 'ftilde/vim-ugdb'
Plug 'folke/trouble.nvim', {'branch': 'main'}
Plug 'kaarmu/typst.vim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'kyazdani42/nvim-web-devicons'             " for symbols

" Languages
Plug 'rust-lang/rust.vim'
Plug 'tridactyl/vim-tridactyl'

" Pope
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" Statusline
Plug 'nvim-lualine/lualine.nvim'
Plug 'arkav/lualine-lsp-progress'
Plug 'SmiteshP/nvim-navic'

" Utils
Plug 'reedts/vim-hybrid'
Plug 'airblade/vim-gitgutter'
Plug 'chriskempson/base16-vim'
Plug 'frazrepo/vim-rainbow'
Plug 'kshenoy/vim-signature'
Plug 'machakann/vim-highlightedyank'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'tommcdo/vim-lion'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'RRethy/vim-illuminate'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'ntpeters/vim-better-whitespace'

" Initialize plugin system
call plug#end()
" }}}

" Colorscheme {{{
let base16colorspace=256
set termguicolors
" colorscheme base16-tomorrow-night-eighties
set background=dark
colorscheme hybrid

lua << EOF
require'nvim-web-devicons'.setup {
	override = {
		rs = {
			icon = '',
			color = "#dea584",
			name = "Rs"
		}
	}
}
EOF
"}}}

" Statusline {{{

lua require("lualine_config")
" }}}


"LaTeX-Suite {{{
filetype plugin on
let g:tex_flavor = 'latex'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_latexmk = {
    \   'build_dir': './build'
    \}
"}}}

" Key bindings {{{
" map space to mapleader
nnoremap <space> <nop>
let mapleader = " "

nmap     <leader>nn <cmd>NERDTreeToggle<cr>
nmap     <leader>tg <cmd>TagbarToggle<cr>
nmap     <leader>ee <plug>(esearch)
noremap  <leader>w  <cmd>call TrimWhitespace()<cr>
nnoremap <leader>u :UndotreeToggle<cr>

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

" Completion {{{
set completeopt=menu,menuone,noselect

lua require("cmp_config")

" hi! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#999999

" hi! CmpItemAbbrMatch guibg=NONE guifg=#6699cc
" hi! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#66cccc

" hi! CmpItemKind guibg=NONE guifg=#ffcc66

" }}}

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
nnoremap <silent> <Leader>la <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <Leader>lf <cmd>lua vim.lsp.buf.format { async = true }<CR>
nnoremap <silent> <Leader>ls <cmd>lua vim.diagnostic.open_float({scope="line"})<CR>
nnoremap <silent> <Leader>lx <cmd>lua toggle_diagnostics()<CR>

nnoremap <silent> ]g <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> [g <cmd>lua vim.diagnostic.goto_prev()<CR>

" Colour
hi DiagnosticError gui=bold   guifg=#f2777a
hi DiagnosticWarn  gui=NONE   guifg=#f99157
hi DiagnosticInfo  gui=italic guifg=#ffcc66
hi DiagnosticHint  gui=italic guifg=#999999

hi DiagnosticUnderlineError guifg=#f2777a guibg=#653c3d
hi DiagnosticUnderlineWarn cterm=NONE gui=NONE
hi DiagnosticUnderlineInfo cterm=NONE gui=NONE
hi DiagnosticUnderlineHint cterm=NONE gui=NONE

hi DiagnosticSignError gui=bold guifg=#f2777a guibg=NONE
hi DiagnosticSignWarn  gui=NONE guifg=#f99157 guibg=NONE
hi DiagnosticSignInfo  gui=NONE guifg=#ffcc66 guibg=NONE
hi DiagnosticSignHint  gui=NONE guifg=#999999 guibg=NONE

sign define DiagnosticSignError text=✗ texthl=DiagnosticSignError linehl= numhl=
sign define DiagnosticSignWarn  text= texthl=DiagnosticSignWarn  linehl= numhl=
sign define DiagnosticSignInfo  text= texthl=DiagnosticSignInfo  linehl= numhl=
sign define DiagnosticSignHint  text= texthl=DiagnosticSignHint  linehl= numhl=

lua require("trouble").setup()
nnoremap <leader>tt <cmd>TroubleToggle<cr>
nnoremap <leader>tw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>td <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>tq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>tl <cmd>TroubleToggle loclist<cr>
nnoremap <leader>tlr<cmd>TroubleToggle lsp_references<cr>
" }}}

" NvimTree {{{
lua require("nvimtree_config")
nnoremap <leader>nn <cmd>NvimTreeToggle<cr>
" }}}

" {{{ Treesitter

lua require("treesitter_config")

" }}}

" {{{ Telescope

lua require("telescope_config")

nnoremap <silent> <leader>ff <cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <silent> <leader>fi <cmd>lua require('telescope.builtin').git_files()<CR>
nnoremap <silent> <leader>fg <cmd>lua require('telescope.builtin').grep_string()<CR>
nnoremap <silent> <leader>fb <cmd>lua require('telescope.builtin').buffers({ show_all_buffers = true })<CR>
nnoremap <silent> <leader>flg <cmd>lua require('telescope.builtin').live_grep()<CR>

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

" let g:indentLine_color_gui = '#515151'
hi IndentBlanklineChar guifg=#515151 gui=nocombine
hi IndentBlanklineContextChar guifg=#ffcc66 gui=nocombine
hi IndentBlanklineContextStart guisp=#2d2d2d gui=bold

let g:indent_blankline_char = '│'

lua require("indent_config")
" }}}

" Illuminate {{{
let g:Illuminate_delay = 1000
" }}}

" Better Whitespaces {{{
hi! link ExtraWhitespace DiagnosticUnderlineError

let g:strip_whitespace_on_save = 0
let g:better_whitespace_filetypes_blacklist = ['Troube', 'NvimTree', 'Telescope', 'diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'fugitive']

" }}}
" Directory specific settings {{{
set exrc secure
"}}}
" vim: fdm=marker
