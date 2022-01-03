" ====================
" 1: UNIVERSAL CONFIGS
" ====================

set nocompatible
set encoding=utf-8
scriptencoding utf-8
set number
set ruler
syntax enable
set noerrorbells
set ttyfast
set autoread

set t_ut="" " use the colorscheme background color, not the terminal one

set path+=** " for find and such

let g:mapleader = ' '

set noswapfile

" Because I sometimes use fish
set shell=/bin/bash

"search settings
set ignorecase
set hlsearch
set incsearch
set smartcase

set title

set backspace=2 " Allow backspace as delete in insert mode

set hidden
set wrapscan

set undofile

set mousehide
set scrolloff=8

set history=1000
set undolevels=1000

set synmaxcol=361
set laststatus=2 "this turns the status line on by default
set smartindent

" set key-chord time out to half of the default
set timeoutlen=500

set clipboard=unnamed

" this hightlights the number trough when the corresponding line is Held
hi! link CursorLineNr CursorLine

"autocomplete for commands
set wildmode=longest:full
set wildmenu

set list
set listchars=tab:▸\ ,trail:·,nbsp:␣

let g:python3_host_prog = '/Users/maxlebedev/.virtualenvs/screen/bin/python'

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

if has('nvim')
	Plug 'nvim-treesitter/nvim-treesitter'
	" Intellisense engine
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> <leader>] <Plug>(coc-diagnostic-next)
	nmap <silent> <leader>[ <Plug>(coc-diagnostic-prev)

	" Plug 'lukas-reineke/indent-blankline.nvim'

endif



Plug 'haya14busa/incsearch.vim'
" Plug 'easymotion/vim-easymotion'
Plug 'unblevable/quick-scope'

augroup qs_colors
  autocmd!
	autocmd ColorScheme * highlight QuickScopePrimary gui=underline ctermfg=NONE cterm=underline
	autocmd ColorScheme * highlight QuickScopeSecondary gui=undercurl ctermfg=NONE cterm=undercurl
augroup END

" color schemes
" Plug 'joshdick/onedark.vim'
" Plug 'sainnhe/sonokai'
Plug 'sainnhe/edge'

Plug 'tpope/vim-fugitive'
nnoremap <leader>gb :Git blame<CR>

" highlight other uses of the word under cursor
Plug 'RRethy/vim-illuminate'

" git diff in the vim gutter
Plug 'airblade/vim-gitgutter'
highlight clear SignColumn " remove the ugly grey background
let g:gitgutter_set_sign_backgrounds = 1
highlight GitGutterAdd    ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red

Plug 'mbbill/undotree'
nmap <leader>u :UndotreeToggle<CR>

" tag-based code overview panel
" Plug 'preservim/tagbar'
Plug 'majutsushi/tagbar'

nmap <leader>t :TagbarToggle<CR>
" This controls the tagbar 'refresh' but also the swap file refresh frequency in ms.
" default is 4000, and low values cause problems.
set updatetime=500


" Display marks sidebar because I'm a visual person
Plug 'Yilin-Yang/vim-markbar' " open on `

" experimentally turning this off to see if coc-pyright is doing this for me
" Plug 'a-vrma/black-nvim', {'do': ':UpdateRemotePlugins'}

Plug 'sheerun/vim-polyglot'

" This is in theory better because it uses LSP, but I didn't like it
" Plug 'liuchengxu/vista.vim'
" nmap <leader>t :Vista!!<CR>

Plug 'metakirby5/codi.vim'

call plug#end()

filetype indent plugin on " read all filetype specific plugins. None by default automatic indentation

colorscheme edge
" ==================
" 3: CUSTOM SETTINGS
" ==================

" KINESIS MODE
noremap j h
noremap k gj
noremap l gk
noremap ; l

" arrow keys as window movement
noremap <Left> <c-w>h
noremap <Down> <c-w>j
noremap <Up>  <c-w>k
noremap <Right> <c-w>l

" Shift arrow to C-W hjkl
noremap <S-Left> <c-w>H
noremap <S-Down> <c-w>J
noremap <S-Up>  <c-w>K
noremap <S-Right> <c-w>L
" END KINESIS MODE

" open current file in new tab
" :tab split

" :sp f open file in new split
" :vsp gf open file in vertical split

" return from a move
nnoremap <Leader><BS> <C-o>

" move between tabs
nnoremap <leader>j gT
nnoremap <leader>; gt

"toggle relative and absolute number line
nnoremap <F3> :set rnu!<CR>

" w! sudo saves
cmap w! w !sudo tee % >/dev/null

set spell spelllang=en_us
" instead of red blocks, underline misspelled words
hi clear SpellBad
hi clear SpellLocal
hi clear SpellCap
hi SpellBad cterm=underline

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

" open string as split file
nmap <Leader>o <C-w><C-f>
" gf is the same but in the same buffer

if executable('rg')
	set grepprg=rg\ --vimgrep
endif

"TODO: we want to not do this when a file is created
"This does not work with multi-row lines, or for the first file
function! AutoTrimLength()
    let l:linenum = line('$')
    if l:linenum < 30 && l:linenum > 1 " only shrink small, non-empty files
        execute 'resize' l:linenum
    endif
endfunction

au BufRead,BufNewFile *.ts setlocal  filetype=typescript
au VimResized * wincmd =

" nnoremap Q :call autoTrimLength()<CR>
" augroup bufsize
"     autocmd BufWinEnter * :call AutoTrimLength()
" augroup END

" replace the current word with the last yanked text
" TODO: lines shouldn't keep \n, and don't overwrite the yank buffer
nnoremap <leader>rr viw"0p

" dumb hack to go back to what I was doing
nnoremap <leader>gg uU

" Triger `autoread` when files changes on disk
" autocmd FocusGained,BufEnter * if mode() != 'c' | checktime | endif
" Notification after file change

" look, a cool thing
" :new | set buftype=nofile | read !ag "SearchTerm" -G .py

function Search(search_term)
    :new | set buftype=nofile | read !ag a:search_term -G .py <CR>
endfunction
nnoremap <leader>s :call Search(expand("<cword>")) <CR>


" autocmd BufWritePre *.py silent execute ':!black %'
" autocmd BufWritePre *.py silent execute '! isort %' " sometimes isort conflicts with black
" autocmd BufWritePre *.py execute 'call Black()'
autocmd BufWritePre *.tf execute '!terraform fmt'


" this (hopefully lets us leave term
if has('nvim')
    tnoremap <ESC> <C-\><C-n>
    set undodir=/Users/maxlebedev/.nvimundo/
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


" reload current vim
" nnoremap <Leader>rr :mksession ~/.vim/tmp_sesh.vim
" vim -S ~/mysession.vim

" vertical is v, and wincmd is C-W
" vertical wincmd

" all scr files are temp
autocmd BufNewFile scr :set buftype=nofile
autocmd BufNewFile tmp :set buftype=nofile

" Session save and restore
" Automatically save the current session whenever vim is closed
autocmd VimLeave * mksession! ~/.vim/shutdown_session.vim
autocmd VimEnter source ~/.vim/shutdown_session.vim<CR>


" TODO: implementing undo close split
" the altbuf can be set right before/after a file close
" this way, when reopening, we can look at the altbuf to see what to opten
" in theory we can use some other register, too

" let altbuf = bufnr(@#)
" let @# = altbuf

" TODO: implement a composable 'new-split' cmd
" I want to be able to do :sp CocConfig
" and get the config file open in a new tab

" by default, have * hightlight the current word for searching, but not move
nnoremap <silent> * :execute "normal! *N"<cr>

" Reassign gu to search for current word usage
nnoremap gu : execute "normal! *N"<bar> new <cword> <bar> set buftype=nofile <bar> set bufhidden=unload <bar> read !ag "%"
