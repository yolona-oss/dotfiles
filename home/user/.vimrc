set nocompatible
filetype off

"############################
"	PLUGGIN SETUP
"############################
let g:plug_threads = 4
let g:plug_retries = 3

filetype plugin on
filetype plugin indent on

call plug#begin('~/.vim/plugged')
"Genral
Plug 'https://github.com/vim-scripts/vim-auto-save.git'
Plug 'https://github.com/bling/vim-bufferline'
Plug 'https://github.com/SirVer/ultisnips'
"Plug 'honza/vim-snippets'

"Text completing
Plug 'https://github.com/ycm-core/YouCompleteMe.git'
"Plug 'https://github.com/xavierd/clang_complete'
Plug 'https://github.com/tpope/vim-commentary'

"Project ordering
Plug 'https://github.com/preservim/nerdtree.git'
Plug 'https://github.com/ctrlpvim/ctrlp.vim'

"Configuration
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'https://github.com/vim-scripts/AfterColors.vim'
call plug#end()

"############################
"         CONTENT
"############################
"
"
"
"

"############################
"	 1. GENERAL
"############################
set number
set relativenumber
syntax on
set viminfo='20,<100,:100,%,n~/.vim/viminfo
set encoding=utf-8
set fileencoding=utf-8
set exrc	"use local ./vimrc for each dir	
set secure	"disallow to run autocmd in local ./vimrc
set smartcase	"for serach
set ignorecase	""
"set smartindent

"window settings
set noequalalways
set winheight=20

autocmd filetype c,cpp set cin

"augroup project
"    autocmd!
"    autocmd BufRead,BufNewFile *.h,*.c set filetype=c
"augroup END

"######################
"   2. SHORTCUTS
"######################

" Leader Key "let mapleader = \ 

"##############################
"   2.1 MOVING SHORTCUTS
"##############################
" Buffer switching left, down, up, right
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

" Mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" NERDTree
map <c-n> :NERDTreeToggle<CR>

"############################
"   3. COLORS AND FONTS
"############################

colorscheme darkblue

"###################
"   4. PLUGINS
"###################

"############################
"     4.1 YouCompleteMe
"############################

"let &rtp .= ',' . expand( '<sfile>:p:h' )

let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_keep_logfiles = 1
let g:ycm_log_level = 'debug'
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'


"######################
"   4.2 NERDTree
"######################

" Autostart
autocmd StdinReadPre * let s:std_in=1
" Show NERDTree window if vim opened without arguments
if argc() == 0
	autocmd VimEnter * NERDTree code
	autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | endif " Autostart when use stored session
	autocmd vimenter * NERDTree 	" Common autostart
endif

" Closing NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"autocmd BufEnter * lcd %:p:h
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
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
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

let g:auto_save = 30
let g:auto_save_no_updatetime = 1 
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1
"let g:auto_save_postsave_hook = cmd "run cmd after save

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


"########################
"   4.6 Bufferline
"########################

let g:bufferline_active_buffer_right = ']'
let g:bufferline_active_buffer_left = '['

"
"
"

"###################
"   4.6 CLANG
"###################

"path to directory where library can be found
"let g:clang_library_path='/usr/lib/llvm-3.8/lib'
"or path directly to the library file
"let g:clang_library_path='/usr/lib64/libclang.so.3.8'

"#####################
" Snippets                                                                      
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
