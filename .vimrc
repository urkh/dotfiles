call pathogen#helptags()
call pathogen#infect()
filetype on
filetype plugin on
filetype indent on


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
