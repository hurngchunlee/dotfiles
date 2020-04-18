""" enable hybrid number and relative line number
set number relativenumber

""" set vim encoding to UTF-8
set encoding=UTF-8

""" plugins
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/NERDTree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'tomasiser/vim-code-dark'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lilydjwg/colorizer'
call plug#end()

""" set color scheme
colorscheme codedark

""" set syntax highlighting
syntax on
set cursorline
set cursorcolumn

""" nerdtree toggle settings
map <A-o> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

""" remove the default nerdtree arrow indicating folder open/close
let NERDTreeDirArrowExpandable = ""
let NERDTreeDirArrowCollapsible = ""

""" enable folder open/close effect of devicons
let g:DevIconsEnableFoldersOpenClose = 1

""" highlight nerdtree with icons and colors
" let g:NERDTreeLimitedSyntax = 1
let g:NERDTreeSyntaxDisableDefaultExtensions = 1
let g:NERDTreeSyntaxDisableDefaultExactMatches = 1
let g:NERDTreeSyntaxDisableDefaultPatternMatches = 1
let g:NERDTreeSyntaxEnabledExtensions = ['c', 'h', 'c++', 'cpp', 'js', 'json', 'md', 'css', 'html', 'go']

""" configuration for airline
set t_Co=256

let g:airline#extensions#tabline#enabled = 1
nnoremap <A-tab>   :bnext<CR>

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#languageclient#enabled = 1

let g:airline_theme = 'codedark'

" unicode symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.crypt = ''
"let g:airline_symbols.linenr = ''
"let g:airline_symbols.linenr = ''
"let g:airline_symbols.maxlinenr = '㏑'
"let g:airline_symbols.branch = ''
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.spell = 'Ꞩ'
"let g:airline_symbols.whitespace = 'Ξ'

" powerline-like symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.dirty='⚡'

let g:airline#extensions#whitespace#symbol = '難'

let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
