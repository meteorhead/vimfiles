set nocompatible              " be iMproved, required
filetype plugin on                  " required
" map leader key
map <SPACE> <leader>
set smarttab
set ignorecase


if has('mouse')     " In many terminal emulators the mouse works just fine, thus enable it.
        set mouse=a
endif
"set cursorline
"highlight CursorLine   cterm=NONE ctermbg=NONE ctermfg=darkgreen
" set the runtime path to include Vundle and initialize
:fixdel
" VIM arrow keys not functioning properly on windows
:set term=builtin_ansi
" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" " use indentation of previous line
set autoindent
" " use intelligent indentation for C
set smartindent
" " configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces
" " wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
set textwidth=120
" " turn syntax highlighting on
syntax on
" " colorscheme wombat256
" " turn line numbers on
set number
set backspace=indent,eol,start
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set t_Co=256
if &t_Co > 2 || has("gui_running")
        syntax on       " Switch syntax highlighting on, when the terminal has colors
        set hlsearch        " Also switch on highlighting the last used search pattern.
endif
call plug#begin('~/.vim/plugged')


"Plug 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
" YouCompleteMe
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clang-completer --system-libclang' }
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>
Plug 'w0rp/ale'
Plug 'kien/ctrlp.vim'
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
Plug 'sjl/badwolf'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'
set laststatus=2
Plug 'rhysd/vim-clang-format'
let g:clang_format#auto_format=1
let g:clang_format#code_style='chromium'
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11",
            \ "BreakBeforeBraces" : "Stroustrup"}
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'preservim/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-dispatch'
Plug 'WolfgangMehner/vim-plugins'
Plug 'romainl/vim-cool'
"Plug 'LucHermitte/lh-cpp'
" All of your Plugins must be added before the following line
call plug#end()
call glaive#Install()
" Optional: Enable codefmt's default mappings on the <Leader>= prefix.
Glaive codefmt plugin[mappings]
augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
  autocmd FileType vue AutoFormatBuffer prettier
augroup END
filetype plugin indent on    " required
syntax enable
colorscheme gruvbox
set background=dark
" Make the gutters darker than the background.
let g:badwolf_darkgutter = 1
" undodir
set undodir=~/.vim/undodir
set undofile
" make y and p from global buffer that is used by other apps
set clipboard+=unnamedplus
nnoremap <leader>z u
nnoremap <leader>y <C-R>
nnoremap <leader>b <C-b> 
nnoremap <leader>f <C-f> 
" build
":let &makeprg='(cd ~/projects/sandbox/build && make)'
:set makeprg=make\ -C\ ~/projects/sandbox/build
:nnoremap <C-b> :Make<CR>
" run
"nnoremap <C-R> :!../build/%:r<CR>
nnoremap <C-r> :!~/projects/sandbox/build/%:r<CR>
" nerdtree
map <C-n> :NERDTreeToggle<CR>
" Close NERDTree if no other window is open
 "autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
 " move among buffers with CTRL
 map <C-x> :bdelete<CR>
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>
" tagbar focus
nmap <C-t> :TagbarToggle<CR>
let g:tagbar_autofocus=1

nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>
imap <c-s> <Esc><c-s>

nmap <c-q> :q<CR>
imap <c-q> <Esc>:q<CR>
imap <c-q> <Esc><c-q>

au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
     exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

autocmd BufRead,BufNewFile  *.XYZ  set filetype=c
let g:C_SourceCodeExtensions  = 'h cc cp cxx cpp CPP c++ C i ii'
let  g:C_UseTool_cmake    = 'yes'
let  g:C_UseTool_doxygen = 'yes'
" Disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

"autocmd InsertEnter * :let @/=""
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
