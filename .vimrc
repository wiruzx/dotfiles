filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
syntax on

set path+=**

" Defaults
source $VIMRUNTIME/defaults.vim

" Change grep to ag
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ --vimgrep
    set grepformat^=%f:%l:%c:%m
endif

" Wildmenu
set wildmenu
set wildchar=<C-e>
set wildignore+=**/.git/*

" Relative line numbers
set relativenumber

" Show line number by default
set nu

" A better %
packadd! matchit

" Netrw setup
let g:netrw_banner = 0
let g:netrw_liststyle = 2

" Leader

let mapleader = " "

" FZF
set rtp+=/usr/local/opt/fzf

let g:fzf_layout = { 'down': '100%' }
let g:fzf_preview_window = [ 'up:50%' ]

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'alt-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" TODO: Change letters
nnoremap <leader>bf :Buffers<CR>
nnoremap <leader>ps :GFiles<CR>
nnoremap <leader>gf :GFiles?<CR>
nnoremap <leader>fs :Files<CR>
nnoremap <leader>ls :Lines<CR>
nnoremap <leader>bs :BLines<CR>
nnoremap <leader>ag :Ag<Space>
nnoremap <leader>ga :Ag<Space><CR>

" An easy way to leave insert mode
inoremap jj <ESC>

" Commands for inserting empty lines
nnoremap <leader>O O<Esc>
nnoremap <leader>o o<Esc>

" Hide unopened buffers
set hidden

" Highlight cursor position
set cul
set culopt=number

" Make ' jump to the column as well as the line
map ' `

" Setup search
set hlsearch
set incsearch
set nowrapscan

" Save on S
nnoremap S :w<CR>

" Space Space
nnoremap <leader><leader> :noh<CR>

" Golden Ratio
let g:golden_ratio_autocommand = 0
noremap <leader>gr :GoldenRatioToggle<CR>

" No wrap!
set nowrap

" Quick fix list keybindings

nnoremap QL :lopen<CR>
nnoremap QQ :copen<CR>
nnoremap p :lprev<CR>
nnoremap n :lnext<CR>
nnoremap b :cprev<CR>
nnoremap f :cnext<CR>

" Windows Management

" Jumping
nnoremap l <C-w>l
nnoremap h <C-w>h
nnoremap j <C-w>j
nnoremap k <C-w>k
nnoremap w <C-w><C-w>
nnoremap q <C-w>W

" Jumping in terminal

tnoremap l <C-w>l
tnoremap h <C-w>h
tnoremap j <C-w>j
tnoremap k <C-w>k
tnoremap w <C-w><C-w>
tnoremap q <C-w>W

" Moving
nnoremap L <C-w>L
nnoremap H <C-w>H
nnoremap J <C-w>J
nnoremap K <C-w>K

" Moving in terminal
tnoremap L <C-w>L
tnoremap H <C-w>H
tnoremap J <C-w>J
tnoremap K <C-w>K

" Splitting
nnoremap x <C-w>s
nnoremap v <C-w>v
nnoremap c <C-w>c
nnoremap o <C-w>o

" Splitting in terminal
tnoremap x <C-w>s
tnoremap v <C-w>v
tnoremap c <C-w>c
tnoremap o <C-w>o


" Resizing
nnoremap \ <C-w>_ <C-w>\|
nnoremap = <C-w>=
nnoremap <Up> :resize +5<CR>
nnoremap <Down> :resize -5<CR>
nnoremap <Left> :vertical resize -5<CR>
nnoremap <Right> :vertical resize +5<CR>

" Resizing in terminal
tnoremap \ <C-w>_ <C-w>\|
tnoremap = <C-w>=
tnoremap <Up> <C-w>:resize +5<CR>
tnoremap <Down> <C-w>:resize -5<CR>
tnoremap <Left> <C-w>:vertical resize -5<CR>
tnoremap <Right> <C-w>:vertical resize +5<CR>

" Tabs management
nnoremap <leader>nt :tabe<CR>

nnoremap , :tabprev<CR>
nnoremap . :tabnext<CR>
nnoremap < :-tabmove<CR>
nnoremap > :+tabmove<CR>

" Tabs management in terminal
tnoremap , <C-w>:tabprev<CR>
tnoremap . <C-w>:tabnext<CR>
tnoremap < <C-w>:-tabmove<CR>
tnoremap > <C-w>:+tabmove<CR>

" Terminal hotkey

nnoremap <leader>te :term<CR>

" Accessing buffer in terminal mode

tnoremap  <C-w>"0

" Leaving everything

inoremap  <C-\><C-n>
tnoremap  <C-\><C-n>
cnoremap  <C-\><C-n>

" Accessing command and search history

noremap <leader>; q:
noremap <leader>/ q/

" Colorscheme
colorscheme gruvbox8

" Change the default splits

set splitbelow splitright

" Insert space
nnoremap <Leader>s i<Space><Esc>
nnoremap <Leader>S a<Space><Esc>

" Split the line

nnoremap <leader>x i<CR><Esc>

" Copy current file path, name

nnoremap <leader>cf :let @" = expand("%:t")<CR>
nnoremap <leader>cp :let @" = expand("%")<CR>

" Git gutter setup

set updatetime=100
let g:gitgutter_signs = 0

nnoremap <leader>gs :GitGutterStage<CR>
nnoremap <leader>gu :GitGutterUndoHunk<CR>
nnoremap <leader>gl :GitGutterSignsToggle<CR>

" Diff
nnoremap <leader>dt :difft<CR>
nnoremap <leader>do :diffoff<CR>

" Insert mode emacs's support

inoremap <C-a> <C-o>0
inoremap <C-e> <C-o>$

" Control-jumps

nnoremap <C-j> 6j
nnoremap <C-k> 6k
nnoremap <C-h> 12h
nnoremap <C-l> 12l

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'roman/golden-ratio'
Plug 'airblade/vim-gitgutter'
Plug 'idbrii/vim-argedit'

call plug#end()
