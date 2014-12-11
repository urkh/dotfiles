"vundle
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
"Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'https://github.com/andviro/flake8-vim.git'
Plugin 'https://github.com/vim-scripts/AutoComplPop.git'
Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'https://github.com/kien/ctrlp.vim.git'
Plugin 'https://github.com/Lokaltog/powerline.git'
Plugin 'https://github.com/scrooloose/syntastic.git'
Plugin 'elzr/vim-json'
" The sparkup vim script is in a subdirectory of this repo called vim.
"" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
":PluginInstall    
"- installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"nerdtree
"autocmd vimenter * NERDTree

"para pep8
let g:pep8_map='whatever' 
let g:PyFlakeOnWrite = 1
let g:PyFlakeCheckers = 'pep8,mccabe,frosted'
let g:PyFlakeCheckers = 'pep8,mccabe,frosted'
let g:PyFlakeDisabledMessages = 'E501'
let g:PyFlakeAggressive = 0
let g:PyFlakeCWindow = 6 
let g:PyFlakeSigns = 1 
let g:PyFlakeRangeCommand = 'Q'

"call pathogen#helptags()
"call pathogen#infect()
"execute pathogen#infect()
"execute pathogen#infect('stuff/{}')
"filetype on
"filetype plugin on
"filetype indent on
"filetype plugin indent on


syntax on
set number
set showmatch
set ignorecase
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
colorscheme delek
set pastetoggle=<f8>
inoremap <Nul> <C-X><C-O>
set cursorline

"let g:molokai_original = 1
"let g:rehash256 = 1


map <C-n> :tabn<Enter>
map <C-t> :tabnew<Enter>
"map nt :NERDTreeTabsToggle<Enter>
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>
"
au BufNewFile,BufRead *.qml set filetype=qml
