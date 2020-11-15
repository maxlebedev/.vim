set nocompatible
set encoding=utf-8
scriptencoding utf-8
set number
set ruler
syntax enable
set background=dark
set noerrorbells
set ttyfast
set autoread

" for find and such
set path+=**

let g:mapleader = ' '

set noswapfile

" use tags: ] to go to the definition of the curren token, [ to go back
command! MakeTags !ctags -R .
nnoremap <Leader>] <C-]>
nnoremap <Leader>g] g<C-]>
nnoremap <Leader>[ <C-t>

" TODO: Does [ and BS do anything meaningfully different?

" lookup funciton definition by tag
nnoremap gp <C-w>}
nnoremap gz <C-w>z # close preview window


" return from a move
nnoremap <Leader><BS> <C-o>

" insert language boilerplate
nnoremap <Leader>pdb  :read $HOME/.vim/snippets/pdb.py<ESC>==
" nnoremap <Leader>pymain :read $HOME/.vim/snippets/pyboil.py<CR>
" nnoremap <Leader>jcl :read $HOME/.vim/snippets/javaclass.java<CR>2f
nnoremap <Leader>sh :read $HOME/.vim/snippets/shboil<CR>

" Because I sometimes use fish
set shell=bash

" by defualt, this woild hide all other splits.
" Insteas we open the buffer in a new tab
noremap   <C-w><C-o>  :tab sp<CR>

"autocomplete for commands
set wildmode=longest:full
set wildmenu

"search settings
set ignorecase
set hlsearch
set incsearch
set smartcase

set title

set backspace=2 " Allow backspace as delete in insert mode

set hidden
set wrapscan


set mousehide
set scrolloff=8

set history=1000
set undolevels=1000

"  KINESIS MODE
noremap ; l
noremap l gk
noremap k gj
noremap j h
" map <m-k> <c-w>j
" map <m-l> <c-w>k
" map <m-;> <c-w>l
" map <m-j> <c-w>h
noremap <c-w>j <c-w>h
noremap <c-w>k <c-w>j
noremap <c-w>l <c-w>k
noremap <c-w>; <c-w>l
"alternate window movement
noremap <c-j> <c-w>h
noremap <c-k> <c-w>j
noremap <c-l> <c-w>k
noremap <c-;> <c-w>l

" since we are not using arrow keys, they can be window movement
noremap <Left> <c-w>h
noremap <Down> <c-w>j
noremap <Up>  <c-w>k
noremap <Right> <c-w>l

"Cursor should move up/down a single row on the screen rather than to the next
"line. useful for line lines taking up multiple rows
" :nmap j gj
" :nmap k gk

:nnoremap <leader>j gT
:nnoremap <leader>; gt

"toggle relative and absolute number line
nnoremap <F3> : set rnu!<CR>

" W sudo saves
cmap w! w !sudo tee % >/dev/null

"make newlines with [enter] without having to go to insert mode (myself).
nmap <leader><cr> i<cr><Esc>

"spelling
set spelllang=en

set spell spelllang=en_us
" instead of red blocks, underline misspelled words
hi clear SpellBad
" hi SpellBad cterm=underline
set nospell


" consider giving TabTab to something better
" map <Tab><Tab> <C-W>w

" set crosshairs
hi CursorLine cterm=NONE ctermbg=DarkGray ctermfg=NONE
hi CursorColumn cterm=NONE ctermbg=DarkGray ctermfg=NONE
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

nnoremap Y y$
nnoremap U :redo<CR>

"this function replaces s with a single insert
function! RepeatChar(char, count)
    return repeat(a:char, a:count)
endfunction
nnoremap s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
nnoremap S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>

" prevent the command line history buffer from happening
" map q: :q


" we want to map C-Space to C-n
" inoremap <C- > <C-n>

" this hightlights the number trough when the corresponding line is HLed
hi! link CursorLineNr CursorLine

set laststatus=2 "this turns the status line on by default

" provide some sort of alternative to ESC
inoremap jj <ESC>


" ------------------------ Plugins

" if plug.vim is not installed, install it
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" git plugin, enables git blame
Plug 'tpope/vim-fugitive'
nnoremap <leader>gb :Gblame<CR>

" highlight other uses of the word under cursor
Plug 'RRethy/vim-illuminate'

" git diff in the vim gutter
Plug 'airblade/vim-gitgutter'

" tree visualiser for vim undo
Plug 'mbbill/undotree'
nmap <leader>u :UndotreeToggle<CR>

" tag-based code overview panel
Plug 'majutsushi/tagbar'
nmap <leader>t :TagbarToggle<CR>
" This controls the tagbar 'refresh' but also the swap file refresh frequency in ms.
" default is 4000, and low values cause problems.
set updatetime=500

"   Plug 'francoiscabrol/ranger.vim'

" session management/restore
call plug#end()


"" Plugin 'Valloric/YouCompleteMe'
"" let g:ycm_autoclose_preview_window_after_completion=1
"" let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
"" let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
"" let g:ycm_complete_in_comments = 1 " Completion in comments
"" let g:ycm_complete_in_strings = 1 " Completion in string
"
"" let g:ycm_key_list_select_completion = ['<C-j>', '<Down>'] " C-j/k to navigate
"" let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
"
"Plugin 'tpope/vim-obsession'
"Plugin 'tpope/vim-surround'
"
"Plugin 'vim-airline/vim-airline'
"let airline#extensions#ale#error_symbol = '✘'
"let airline#extensions#ale#warning_symbol = '⚠'
"let g:airline#extensions#ale#enabled = 1
"let g:airline#extensions#branch#format = 1
"" not convinced that this works
"let g:airline#extensions#default#layout = [ [ 'a', 'c' ], [ 'error', 'warning', 'b' ] ]
"" refresh after setup
"autocmd VimEnter * :AirlineRefresh
"
"
"Plugin 'vim-scripts/indentpython.vim'
"
"Plugin 'w0rp/ale.git'
"let g:ale_sign_error = '◉ '
"let g:ale_sign_warning = '◉'
"let g:ale_python_flake8_options = '--ignore=E501'
"let g:ale_set_signs = 1
"let g:ale_set_highlights = 1
"let g:ale_completion_enabled=1
"" this gets us SOME python aurocompletion, but its not very good
"let g:ale_linters_explicit = 1
"let b:ale_linters = {
"\    'python': ['pyls', 'flake8', 'yapf', 'mypy'],
"\    'javascript': ['eslint'],
"\    'typescript': ['tsserver', 'tslint']
"\}
"
"let g:ale_fixers = {
"\    'javascript': ['eslint'],
"\    'typescript': ['prettier'],
"\    'scss': ['prettier'],
"\    'html': ['prettier']
"\}
"let g:ale_fix_on_save = 1
"
"highlight clear SignColumn
"hi ALEErrorSign ctermfg=9 ctermbg=None
"hi link ALEWarningSign  Warning
"
"set omnifunc=ale#completion#OmniFunc
""and use a non-emacs style shortcut for it.
"inoremap <leader><Tab> <C-x><C-o>
"
"
"" Plugin 'shougo/deoplete.nvim'
"" Plugin 'roxma/nvim-yarp'
"" Plugin 'roxma/vim-hug-neovim-rpc'
"" let g:deoplete#enable_at_startup = 1
"
"" Plugin 'james9909/stackanswers.vim'
"
"Plugin 'junegunn/fzf.vim' " find files, find tags
"nmap <leader>ff :Files<CR>
"" Ctrl + X: is :sp, Ctrl + T is :tabe
"nmap <leader>ft :Tags<CR>
"nmap <leader>fs :Ag
"nmap <leader>fc :Commits<CR>
"" https://github.com/junegunn/fzf.vim  " make these nice
"
"Plugin 'easymotion/vim-easymotion'
"map <Leader> <Plug>(easymotion-prefix)
"
"
"Plugin 'leafgarland/typescript-vim'
"
"" Plugin 'mattn/emmet-vim'
"" let g:user_emmet_leader_key=','
"" example div>p#foo$*5>a ,, makes those tags
"
"" Plugin 'rubik/vim-radon'
"
"" All of your Plugins must be added before the following line
"call vundle#end()            " required
"filetype plugin indent on    " required
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

filetype indent plugin on " read all filetype specific plugins. None by default automatic indentation

set smartindent

" first time mark, then swap repeat
function! DoWindowSwap()
    if exists('g:markedWinNum')
        "Mark destination
        let l:curNum = winnr()
        let l:curBuf = bufnr( '%' )
        exe g:markedWinNum . 'wincmd w'
        "Switch to source and shuffle dest->source
        let l:markedBuf = bufnr( '%' )
        "Hide and open so that we aren't prompted and keep history
        exe 'hide buf' l:curBuf
        "Switch to dest and shuffle source->dest
        exe l:curNum . 'wincmd w'
        "Hide and open so that we aren't prompted and keep history
        exe 'hide buf' l:markedBuf
        unlet g:markedWinNum
    else
        let g:markedWinNum = winnr()
        echo 'window marked'
    endif
endfunction

nmap <silent> <leader>w :call DoWindowSwap()<CR>

"search for selected text
vnoremap // y/<C-R>"<CR>

set clipboard=unnamed

" open string as file
nmap <Leader>o <C-w><C-f>

set synmaxcol=361

"Silver searcher
let g:ackprg = 'ag --vimgrep'

" tell it to use an undo file
set undofile
" set a directory to store the undo history
set undodir=/Users/maxlebedev/.vimundo/

" set noequalalways
"TODO: we want to not do this when a file is created
"This does not work with multi-row lines, or for the first file
function! AutoTrimLength()
    let l:linenum = line('$')
    if l:linenum < 30 && l:linenum > 1 " only shrink small, non-empty files
        execute 'resize' l:linenum
    endif
endfunction

function! AutoTrimWidth()
    let l:linelen = max(map(getline(1,'$'), 'strchars(v:val)')) + 5 " magic number yay
    execute 'vertical resize' l:linelen
endfunction

au BufRead,BufNewFile *.ts setlocal  filetype=typescript

" nnoremap Q :call autoTrimLength()<CR>
" augroup bufsize
"     autocmd BufWinEnter * :call AutoTrimLength()
" augroup END

"make Escape switch to Terminal-Normal mode:
tnoremap <Esc> <C-w>N
" term setup progress
"   arrowkeys only kinda work
"   paste kinda works

tnoremap  <C-k> <Up>
tnoremap  <C-j> <Down>
tnoremap  <C-h> <C-b>
tnoremap  <C-l> <Right>

" bu undoes a buffer close
augroup buffers
    autocmd BufDelete * let g:latest_deleted_buffer = expand("<afile>:p")
augroup END
nnoremap bu :sp <C-R>=fnameescape(g:latest_deleted_buffer)<CR><CR>


" replace the current word with the last yanked text
nnoremap <leader>rr viw"0p

" dumb hack to go back to what I was doing
nnoremap <leader>gg uU

" Triger `autoread` when files changes on disk
" autocmd FocusGained,BufEnter * if mode() != 'c' | checktime | endif
" Notification after file change

" set key-chord time out to half of the default
set timeoutlen=500
