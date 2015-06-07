"vundle
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'

"Plugin 'tpope/vim-fugitive'
"Plugin 'https://github.com/andviro/flake8-vim.git'
"Plugin 'https://github.com/vim-scripts/AutoComplPop.git'
Plugin 'https://github.com/scrooloose/syntastic.git'
Plugin 'https://github.com/elzr/vim-json.git'
"Plugin 'https://github.com/tomasr/molokai.git'
Plugin 'https://github.com/chrisbra/csv.vim.git'
Plugin 'https://github.com/burnettk/vim-angular.git'
Plugin 'https://github.com/jimenezrick/vimerl.git'

call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on

"
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

" pep8
let g:pep8_map='whatever' 
let g:PyFlakeOnWrite = 1
let g:PyFlakeCheckers = 'pep8,mccabe,frosted'
let g:PyFlakeCheckers = 'pep8,mccabe,frosted'
let g:PyFlakeDisabledMessages = 'E501'
let g:PyFlakeAggressive = 0
let g:PyFlakeCWindow = 0 
let g:PyFlakeSigns = 1 
let g:PyFlakeRangeCommand = 'Q'


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
"set cursorline

"let g:molokai_original = 1
"let g:rehash256 = 1


map <C-n> :tabn<Enter>
map <C-t> :tabnew<Enter>
"map nt :NERDTreeTabsToggle<Enter>
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
au BufNewFile,BufRead *.qml set filetype=qml
