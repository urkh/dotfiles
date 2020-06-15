" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" snippets
Plug 'ncm2/ncm2-ultisnips'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Project
Plug 'scrooloose/nerdtree'

" Plug 'vimlab/split-term.vim'

" UI
Plug 'joshdick/onedark.vim'
Plug 'jonathanfilip/vim-lucius'
Plug 'vim-airline/vim-airline'                                                               
Plug 'vim-airline/vim-airline-themes'
Plug 'sarahlim/wild-cherry-vim'

" Better Visual Guide
Plug 'Yggdroot/indentLine'
Plug 'luochen1990/rainbow'
" Plug 'ryanoasis/vim-devicons'

" syntax check
Plug 'w0rp/ale'

" show git changes
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'

" Autocomplete framework
Plug 'ncm2/ncm2'

" Python auto completion
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-jedi'

" Words in buffer completion
Plug 'ncm2/ncm2-bufword'

" Filepath completion
Plug 'ncm2/ncm2-path'

" Formater
Plug 'Chiel92/vim-autoformat'

" finder
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'

" Lang supports
Plug 'posva/vim-vue'
" Plug 'maxmellon/vim-jsx-pretty'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
" Plug 'janko/vim-test'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'ludovicchabant/vim-gutentags'
" Plug 'kassio/neoterm'
" Plug 'alfredodeza/pytest.vim'

" Initialize plugin system
call plug#end()

" jsx
let g:jsx_ext_required = 1

" Disable Jedi-vim autocompletion and enable call-signatures options
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "1"


" Mostrar mejor mensajes de error
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {
\   'python': ['flake8'],
\   'javascript': ['eslint'],
\   'vue': ['eslint']
\}

let b:ale_python_flake8_options = '--max-line-length=120'
" Run both javascript and vue linters for vue files.
" let b:ale_linter_aliases = ['javascript', 'vue']
" Select the eslint and vls linters.
" let b:ale_linters = ['eslint', 'vls']

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
let g:airline_theme="base16color"
let g:airline#extensions#ale#enabled = 1
let airline#extensions#ale#error_symbol = 'E:'
let airline#extensions#ale#warning_symbol = 'W:'

function! AirlineInit()
    let g:airline_section_a = airline#section#create(['mode', ' ', 'branch'])
    let g:airline_section_b = airline#section#create_left(['ffenc', 'hunks', '%f'])
    let g:airline_section_c = airline#section#create(['filetype'])
    let g:airline_section_x = airline#section#create(['%P'])
    let g:airline_section_y = airline#section#create(['%B'])
    let g:airline_section_z = airline#section#create_right(['%l', '%c'])
endfunction
autocmd VimEnter * call AirlineInit()


" NCM2
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
set shortmess+=c
inoremap <c-c> <ESC>
" make it fast
let ncm2#popup_delay = 5
let ncm2#complete_length = [[1, 1]]
" Use new fuzzy based matches
let g:ncm2#matcher = 'substrfuzzy'


" ctrlP
set runtimepath^=~/.vim/plugged/ctrlp.vim
let g:ctrlp_custom_ignore = '\v\.(npy|jpg|pyc|so|dll)$'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

" UI configuration
syntax on
syntax enable
set showmatch           " Show matching brackets.
set number              " Show the line numbers on the left side.
set relativenumber
set expandtab           " Insert spaces when TAB is pressed.
set tabstop=4           " Render TABs using this many spaces.
set shiftwidth=4        " Indentation amount for < and > commands.
set ignorecase
set smartcase
set noshowmode
set cursorline

" colorscheme
set termguicolors  " Activa true colors en la terminal
colorscheme wildcherry  " Activa tema onedark
set background=dark

" Vertical Rule
highlight ColorColumn ctermbg=darkgray
set colorcolumn=120

" gitgutter
let g:gitgutter_map_keys = 0
set updatetime=100

" Use system wide clipboard by default
set clipboard=unnamedplus,unnamed 

" change tabs
" nnoremap <C-l> :tabprevious<CR>
" inoremap <C-l> <Esc>:tabprevious<CR>i
" nnoremap <C-n> :tabnext<CR>
" inoremap <C-n> <Esc>:tabnext<CR>i
"
"
" Insert mode Movements
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>l
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k

" filetype support 
autocmd FileType vue syntax sync fromstart
autocmd FileType vue setlocal ts=2 sts=2 sw=2
autocmd FileType javascript setlocal ts=2 sts=2 sw=2


" update files for external modifications 
autocmd FocusGained * silent! checktime

" split term
" set splitbelow
" nnoremap <Leader>` :10Term<CR>
" inoremap <Leader>` <Esc>:10Term<CR>i


" NERDTree
" Change Leader
" let mapleader=','
" let maplocalleader='\'
map <Leader>n :NERDTreeToggle<CR> " Show/Hide NerdTree
noremap <Leader>r :NERDTreeFind<CR>  " Find current buffer in nerdtree
let g:NERDTreeMapOpenVSplit='v'      " keep mappings between ctrlp and nerdtree concise
let NERDTreeIgnore=['\.pyc$', '\~$'] " Ignore irrelevant files like pyc and swap files

" snippets
" inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
" let g:UltiSnipsRemoveSelectModeMappings = 0

" set rtp+=/usr/bin/fzf
"



" open cTags on a new tag
map <C-]> :TabExpand 1<CR>

command! -nargs=1 TabExpand call HandleTabTagExpand( <f-args> )

let s:commentchar = """

function HandleTabTagExpand(tagnumber)
    let tagident = expand("<cword>")
    redir @a
    try
        sil exe "tselect ".tagident
    catch /^Vim(\a\+):E433:/ " no tag file
        echom "No tag file found."
        return
    catch /^Vim(\a\+):E426:/ " tag not found
        echom "Tag not found."
        return
    endtry
    redir END
    let tagresults = split(@a, "\n")
    let tagmatches = []
    let linenum = 0
    for line in tagresults
        if linenum % 3 != 1
            " every third line contains the file names
            let linenum = linenum + 1
            continue
        endif
        " figure out where the filename actually starts
        " (it's usually column 32, but it might be farther)
        " one before 32 is 31, but index is 30 since arrays begin at zero
        let filestart = 30
        let c = line[filestart]
        while (filestart < strlen(line))
            let filestart = filestart + 1
            if c == " "
                break
            endif
            let c = line[filestart]
        endwhile
        " store the parsed match in an array
        call add(tagmatches, strpart(line, filestart))
        let linenum = linenum + 1
    endfor
    " navigate to the match specified by tagnumber
    try
        exe "tab drop ".tagmatches[a:tagnumber-1]
    catch /^Vim(\a\+):E471:/ " argument required (means no tag found)
        echom "Tag not found."
    endtry
    let done = 0
    let matchcount = 0
    let f_line = ""
    while done < 1 && matchcount < 1000
        sil exe "/".tagident
        let f_line = getline(".")
        let matchcount = matchcount + 1
        if match(f_line, "^\s+".s:commentchar) < 0
            let done = 1
        endif
    endwhile
    let f_index = stridx( f_line, tagident )
    sil exe "normal 0"
    sil exe "normal ".f_index."l"
endfunction



let g:rainbow_active = 1
autocmd Filetype json :IndentLinesDisable
