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
set path+=/Users/maxlebedev/dm-combined/**
set path+=/Users/maxlebedev/etl/**
set runtimepath+=/usr/local/opt/fzf

let g:mapleader = ' '

" use tags: ctrl+] to jump to tag, prepend g for ambig, ctrl+t to jump back
command! MakeTags !ctags -R .
nnoremap <Leader>] g<C-]> 
nnoremap <Leader>[ <C-t>

" TODO: I installed gtags (GLOBAL) but it doesn't seem to work well at all

" return from a move
nnoremap <Leader><BS> <C-o>

" insert language boilerplate
nnoremap <Leader>pdb  :read $HOME/.vim/snippets/pdb.py<ESC>==
" nnoremap <Leader>pymain :read $HOME/.vim/snippets/pyboil.py<CR>
" nnoremap <Leader>jcl :read $HOME/.vim/snippets/javaclass.java<CR>2f 
nnoremap <Leader>sh :read $HOME/.vim/snippets/shboil<CR>

" Because I sometimes use fish
set shell=bash

" we never want to just lose a bunch of splits
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


set statusline=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]  " airline probably overwrites
set mousehide
set scrolloff=8

set history=1000 
set undolevels=1000  

"  KINESIS MODE
noremap ; l
noremap l k
noremap k j
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
hi SpellBad cterm=underline


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

"this turns on autocompletion
set omnifunc=syntaxcomplete#Complete
"and use a non-emacs style shortcut for it. 
"inoremap <S-Tab> <C-x><C-o>

" we want to map C-Space to C-n
" inoremap <C- > <C-n>

" this hightlights the number trough when the corresponding line is HLed
hi! link CursorLineNr CursorLine

set laststatus=2 "this turns the status line on by default

" provide some sort of alternative to ESC
inoremap jj <ESC>

"==================== HERE BE PLUGINS ====================

" set the runtime path to include Vundle and initialize
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugin 'andymass/vim-tradewinds' # does this require py3.6?

" Plugin 'Valloric/YouCompleteMe'
" let g:ycm_autoclose_preview_window_after_completion=1
" let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
" let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
" let g:ycm_complete_in_comments = 1 " Completion in comments
" let g:ycm_complete_in_strings = 1 " Completion in string

" let g:ycm_key_list_select_completion = ['<C-j>', '<Down>'] " C-j/k to navigate
" let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']

Plugin 'tpope/vim-fugitive'

nnoremap <leader>gb :Gblame<CR>

Plugin 'tpope/vim-obsession'

Plugin 'RRethy/vim-illuminate'

Plugin 'vim-airline/vim-airline'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#branch#format = 1

Plugin 'airblade/vim-gitgutter'

Plugin 'vim-scripts/indentpython.vim'

Plugin 'w0rp/ale.git'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_python_flake8_args = '--ignore=E501'
let g:ale_python_flake8_options = '--ignore=E501'
let g:ale_set_signs = 1
let g:ale_set_highlights = 1
highlight clear SignColumn 
hi link ALEErrorSign    Error
hi link ALEWarningSign  Warning


" Plugin 'shougo/deoplete.nvim'
" Plugin 'roxma/nvim-yarp'
" Plugin 'roxma/vim-hug-neovim-rpc'
" let g:deoplete#enable_at_startup = 1

Plugin 'mbbill/undotree'
nmap <leader>u :UndotreeToggle<CR>

Plugin 'majutsushi/tagbar'
nmap <leader>t :TagbarToggle<CR>
set updatetime=500 " This controls the tagbar 'refresh' but also the swap file refresh frequency in ms.
" default is 4000, and low values cause problems.

" Plugin 'james9909/stackanswers.vim'

Plugin 'junegunn/fzf.vim' " find files, find tags
nmap <leader>ff :Files<CR>
" Ctrl + X: is :sp, Ctrl + T is :tabe
nmap <leader>ft :Tags<CR>
nmap <leader>fs :Ag
nmap <leader>fc :Commits<CR>
" https://github.com/junegunn/fzf.vim  " make these nice

Plugin 'tpope/vim-surround'

Plugin 'mattn/emmet-vim'
let g:user_emmet_leader_key=','
" example div>p#foo$*5>a ,, makes those tags

" Plugin 'rubik/vim-radon'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
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

" not convinced that this works
let g:airline#extensions#default#section_truncate_width = {
            \ 'c': 10,
            \ 'y': 150,
            \ }
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

nmap <silent> <leader>q :call MarkWindowSwap()<CR>
nmap <silent> <leader>w :call DoWindowSwap()<CR>

"search for selected text
vnoremap // y/<C-R>"<CR> 

set clipboard=unnamed
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


" nnoremap Q :call autoTrimLength()<CR>
" augroup bufsize
"     autocmd BufWinEnter *.py :call AutoTrimLength()
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

" F6 undoes a buffer close
augroup buffers
    autocmd BufDelete * let g:latest_deleted_buffer = expand("<afile>:p")
augroup END
nnoremap <F6> :sp <C-R>=fnameescape(g:latest_deleted_buffer)<CR><CR>


" replace the current word with the last yanked text
nnoremap <leader>rr viw"0p

" dumb hack to go back to what I was doing
nnoremap <leader>gg uU

" Triger `autoread` when files changes on disk
autocmd FocusGained,BufEnter * if mode() != 'c' | checktime | endif
" Notification after file change

