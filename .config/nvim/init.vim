syntax enable
filetype plugin indent on
set encoding=utf-8
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=0
set noexpandtab
set foldenable

colorscheme Tomorrow-Night-Eighties

set number relativenumber
set scrolloff=10
set cursorline

"Plugin settings
"------------------------------------------------
"fugative settings
set statusline+=%{fugitive#statusline()}
set statusline^=${coc#status()}

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

"Airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'tomorrow'

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
  


" C syntax plugin
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

" C++ syntax plugin
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1
let c_no_curly_error = 1

"============================================================
"Language supports

"CUDA support
au BufNewFile,BufRead *.cu set ft=cpp

"OpenCL support
au BufNewFile,BufRead *.cl set ft=opencl

"only if LaTeX file use colorcolumn
au BufNewFile,BufRead *.tex set colorcolumn=80

"============================================================

"LaTeX-Suite
filetype plugin on
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_latexmk = {
	\'build_dir': './build',
	\}

set fillchars+=vert:\│

nmap <leader>cl :set cursorline!<cr>
nnoremap <leader>m :w<cr> :silent make\|redraw!\|cw<cr>
nmap <leader>nn :NERDTreeToggle<cr>
nmap <leader>lb :set colorcolumn=80<cr>
nmap <leader>ig :set list!<cr>
nmap <leader>tg :TagbarToggle<cr>

" GitGutter
let g:gitgutter_enabled = 0
nmap <leader>gg :GitGutterToggle<CR>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
" Show buffer menu
nnoremap <C-p> :FZF<CR>

nmap <C-n> :bn<CR>
nmap <C-b> :bp<CR>

nn <silent> <M-d> :LspDefinition<cr>
nn <silent> <M-r> :LspReferences<cr>
nn <silent> <M-=> :LspDocumentFormat<cr>
nn <f2> :LspRename<cr>

let g:fzf_layout = {'down': '~20%'}
let g:fzf_action = {
	\ 'ctrl-t': 'tab split',
	\ 'ctrl-u': 'split',
	\ 'ctrl-i': 'vsplit' }


" THIS IS FOR PLUGGED PLUGINS
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lervag/vimtex'
" Use release branch
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'posva/vim-vue'
Plug 'vim-python/python-syntax'
Plug 'majutsushi/tagbar'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-surround'
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'chrisbra/Colorizer'

" Initialize plugin system
call plug#end()
