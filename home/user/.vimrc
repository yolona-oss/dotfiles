set nocompatible
filetype off

"###################"
"	PLUGGIN SETUP   "
"###################"
let g:plug_threads = 6
let g:plug_retries = 3

filetype plugin on
filetype plugin indent on

call plug#begin('~/.vim/plugged')
	" Genral
	Plug 'vim-scripts/vim-auto-save'
	Plug 'SirVer/ultisnips'
	"Plug 'honza/vim-snippets'

	" Appearance
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	"" Colorscheme
	Plug 'vim-scripts/AfterColors.vim'
	Plug 'rafi/awesome-vim-colorschemes'
	"" Fonts
	Plug 'powerline/fonts'

	" Text completing
	Plug 'ycm-core/YouCompleteMe'
	" Plug 'justmao945/vim-clang'
	Plug 'tpope/vim-commentary'
	Plug 'm-pilia/vim-pkgbuild'
	" Plug 'xavierd/clang_complete'
	" Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
	" Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
	" Plug 'neoclide/coc-java', {'do': 'yarn install --frozen-lockfile'}

	" Naviration
	Plug 'ctrlpvim/ctrlp.vim'
	Plug 'preservim/nerdtree'
	Plug 'vim-scripts/bufkill.vim'
	Plug 'jreybert/vimagit'
	" Plug 'bling/vim-bufferline'

	" Configuration
	Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
call plug#end()

"##########################
"     TABLE OF CONTENT
"##########################
"1. General
"2. Shortcuts
"	2.1 Widnows shortcuts
"	2.2 Tabs shortcuts
"	2.3 Buffers shortcuts
"	2.4 NERDTree
"3.
"4. Plugins
"	4.1 YouCompleteMe
"	4.2 NERDTree
"	4.3 Auto-Save
"	4.4 Ctrl-P
"	4.5 AfterColor
"	4.6 Clang

"##########################
"	    1. GENERAL
"##########################
set number
set relativenumber
syntax on
set viminfo='20,<100,:100,%,n~/.vim/viminfo
set encoding=utf-8
set fileencoding=utf-8
set exrc	"use local ./vimrc for each dir	
set secure	"disallow to run autocmd in local ./vimrc
set smartcase	"smart search
set hlsearch    ""
set ignorecase	""
set lazyredraw
set undofile

set tabstop=4
set shiftwidth=4
set smarttab
" set expandtab
set smartindent

set updatetime=5000

set t_Co=256

" set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %{wordcount()[\"words\"]} 

" window settings
set noequalalways
set winheight=25
" set winwidth=25

autocmd filetype c,cpp set cin

augroup project
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END

"######################
"   2. SHORTCUTS
"######################

" Leader Key "let mapleader = \ 

"##############################
"   2.1 WINDOW SHORTCUTS
"##############################
" Buffer switching left, down, up, right
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

"############################
"   2.2 TABS SHORTCUTS
"############################

" Mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

"##############################
"   2.3 BUFFER SWITCHING
"##############################

map <c-i> :bn<cr>
map <c-o> :bp<cr>
map <c-c> :BD<cr>

nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

"######################
"   2.4 NERDTree
"######################

" NERDTree
map <c-n> :NERDTreeToggle<CR>

"###################
"   4. PLUGINS
"###################

"############################
"     4.1 YouCompleteMe
"############################

"""let &rtp .= ',' . expand( '<sfile>:p:h' )

" let g:ycm_min_num_of_chars_for_completion = 1
" let g:ycm_keep_logfiles = 1
" let g:ycm_log_level = 'debug'
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

"######################
"   4.2 NERDTree
"######################

" Autostart
autocmd StdinReadPre * let s:std_in=1
" Show NERDTree window if vim opened without arguments

if argc() == 0
	autocmd VimEnter * NERDTree projects " Startup default directory
	autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | endif " Autostart when use stored session
endif

" Closing NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

autocmd BufEnter * lcd %:p:h
let g:NERDTreeChDirMode = 2

let NERDTreeShowHidden=0
let NERDTreeShowBookmarks=0
let NERDTreeMinimalUI=1

let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1		" enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1	" highlights the folder name

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
	exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
	exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

" Dir arrows
let g:NERDTreeDirArrowExpandable = '❐ ' "▶
let g:NERDTreeDirArrowCollapsible = '⊿ '
let NERDTreeNodeDelimiter="😀"

let NERDTreeIgnore=[
    \ 'node_modules$[[dir]]',
    \ '.git$[[dir]]',
    \ '.swp$[[file]]',
    \ '.aux[[file]]'
    \ ]


"#######################
"   4.3 AUTO-SAVE
"#######################

let g:auto_save = 360
let g:auto_save_no_updatetime = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1
" let g:auto_save_postsave_hook = cmd "run cmd after save

"###################
"   4.4 CtrlP   
"###################

set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_user_command = 'find %s -type f'

" Ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/](node_modules|target|dist)|(\.(git|hg|svn))$',
	\ 'file': '\v\.(exe|so|dll|DS_Store)$',
	\ 'link': 'some_bad_symbolic_links',
	\ }

"########################
"   4.5 AfterColor
"########################

if argc() == 0
		colorscheme abstract "molokai "heppy_hacking "meta5 "abstract "onedark "pablo "darkblue
else
		colorscheme pablo
endif

"##########################
"    4.6 VIM-AIRLINE
"##########################

autocmd VimEnter * AirlineTheme dark

let g:airline_highlighting_cache = 1

let g:airline_enable_fugitive=1
let g:airline_enable_syntastic=1
let g:airline_enable_bufferline=1

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_fugitive_prefix	= '⎇ '
let g:airline_paste_symbol		= 'ρ'
let g:airline_branch_prefix		= '⎇ '

" " unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.crypt = '🔒'
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.maxlinenr = ''
" let g:airline_symbols.maxlinenr = '㏑'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
" let g:airline_symbols.notexists = 'Ɇ'
" let g:airline_symbols.whitespace = 'Ξ'
                                       
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

" let g:airline_symbols.linenr = '¶'
let g:airline_symbols.paste  = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline_stl_path_style = 'short'

let w:airline_disable_statusline	= 0
let w:airline_skip_empty_sections	= 0
let g:airline_statusline_ontop		= 0

let g:airline_detect_spell=1

" let g:airline_section_a      =
" let g:airline_section_b      =
" let g:airline_section_c      =
" let g:airline_section_gutter =
" let g:airline_section_x      =
" let g:airline_section_y      =
" let g:airline_section_z      =
" let g:airline_section_error  =

let g:airline_extensions = ['branch', 'tabline']

let g:airline#extensions#tabline#fnamemod = ':p:.'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved' "'jsformatter'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ' '

let g:airline#extensions#ycm#enabled = 1

"#####################
" Snippets
" ###################
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

