" TODO: section off 
" 1: necesary/universal configs
" 2: Plugins
" 3: my custom settings

" ====================
" 1: UNIVERSAL CONFIGS
" ====================

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

" Because I sometimes use fish
set shell=bash

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

set synmaxcol=361
set laststatus=2 "this turns the status line on by default
set smartindent

" set key-chord time out to half of the default
set timeoutlen=500


" ==========
" 2: PLUGINS
" ==========

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
" remove the ugly grey background
highlight clear SignColumn
let g:gitgutter_set_sign_backgrounds = 1
highlight GitGutterAdd    ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red

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
Plug 'dense-analysis/ale'

let g:ale_disable_lsp = 1 " letting coc do the lsp work
let g:ale_sign_error = '◉ '
let g:ale_sign_warning = '◉'
"let g:ale_python_flake8_options = '--ignore=E501'
let g:ale_set_signs = 1
let g:ale_set_highlights = 1

highlight clear SignColumn
highlight ALEErrorSign ctermfg=9 ctermbg=None
hi link ALEWarningSign  Warning

"   NEOVIM PLUGINS
if has('nvim')
    Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
    hi semshiUnresolved ctermfg=196 guifg=#ff0000 " make unresolved tokens red

    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    
" This is in theory better because it uses LSP, but I didnt' like it
    "Plug 'liuchengxu/vista.vim'
    "nmap <leader>t :Vista!!<CR>
endif

" session management/restore
call plug#end()

filetype indent plugin on " read all filetype specific plugins. None by default automatic indentation

" ==================
" 3: CUSTOM SETTINGS
" ==================

highlight Pmenu ctermbg=white guibg=white

" TODO: does this fail if no ctags?
" use tags: ] to go to the definition of the curren token, [ to go back
command! MakeTags !ctags -R .
nnoremap <Leader>] <C-]>
nnoremap <Leader>g] g<C-]>
nnoremap <Leader>[ <C-t>

" TODO: Does [ and BS do anything meaningfully different?

" lookup funciton definition by tag
nnoremap gp <C-w>}
nnoremap gz <C-w>z # close preview window

" open curren file in new tab
" :tab split

" :sp f open file in new split
" :vsp gf open file in vertical split

" return from a move
nnoremap <Leader><BS> <C-o>

" insert language boilerplate
nnoremap <Leader>pdb  :read $HOME/.vim/snippets/pdb.py<ESC>==
" nnoremap <Leader>pymain :read $HOME/.vim/snippets/pyboil.py<CR>
" nnoremap <Leader>jcl :read $HOME/.vim/snippets/javaclass.java<CR>2f
nnoremap <Leader>sh :read $HOME/.vim/snippets/shboil<CR>

" by defualt, this woild hide all other splits.
" Insteas we open the buffer in a new tab
noremap   <C-w><C-o>  :tab sp<CR>

"autocomplete for commands
set wildmode=longest:full
set wildmenu

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


" provide some sort of alternative to ESC
inoremap jj <ESC>


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


"Silver searcher
let g:ackprg = 'ag --vimgrep'

" opt into an undo file
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

au BufRead,BufNewFile *.ts setlocal  filetype=typescript

" nnoremap Q :call autoTrimLength()<CR>
" augroup bufsize
"     autocmd BufWinEnter * :call AutoTrimLength()
" augroup END

" replace the current word with the last yanked text
nnoremap <leader>rr viw"0p

" dumb hack to go back to what I was doing
nnoremap <leader>gg uU

" Triger `autoread` when files changes on disk
" autocmd FocusGained,BufEnter * if mode() != 'c' | checktime | endif
" Notification after file change

" look, a cool thing
" :new | set buftype=nofile | read !ag 

autocmd BufWritePost *.py !black %


nnoremap gd <C-w>} " :pc to close preview window

" this (hopefully lets us leave term
if has('nvim')
    tnoremap <ESC> <C-\><C-n>
else
    "make Escape switch to Terminal-Normal mode:
    tnoremap <Esc> <C-w>N
    " term setup progress
    "   arrowkeys only kinda work
    "   paste kinda works

    tnoremap  <C-k> <Up>
    tnoremap  <C-j> <Down>
    tnoremap  <C-h> <C-b>
    tnoremap  <C-l> <Right>
endif
