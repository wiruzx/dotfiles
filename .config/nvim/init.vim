" Plugins
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'roman/golden-ratio'
Plug 'airblade/vim-gitgutter'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'idbrii/vim-argedit'
Plug 'gruvbox-community/gruvbox'

call plug#end()

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
syntax on

" Fix cursor
set guicursor=

" Fix closing terminal for neovim
if has('nvim')
    autocmd TermClose * execute 'bdelete! ' . expand('<abuf>')
endif

"Fix openning terminal in insert mode
if has('nvim')
    autocmd TermOpen term://* startinsert
endif

" Setup wildmenu
set wildmenu
set wildmode=longest,full
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

" Highlight cursor position
set cul
set culopt=number

" Make ' jump to the column as well as the line
map ' `

" Setup search
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
nnoremap <Esc>p :lprev<CR>
nnoremap <Esc>n :lnext<CR>
nnoremap <Esc>b :cprev<CR>
nnoremap <Esc>f :cnext<CR>

" Windows Management

" Jumping
nnoremap <Esc>l <C-w>l
nnoremap <Esc>h <C-w>h
nnoremap <Esc>j <C-w>j
nnoremap <Esc>k <C-w>k
nnoremap <Esc>w <C-w><C-w>
nnoremap <Esc>q <C-w>W

" Jumping in terminal

tnoremap <Esc>l <C-w>l
tnoremap <Esc>h <C-w>h
tnoremap <Esc>j <C-w>j
tnoremap <Esc>k <C-w>k
tnoremap <Esc>w <C-w><C-w>
tnoremap <Esc>q <C-w>W

" Moving
nnoremap <Esc>L <C-w>L
nnoremap <Esc>H <C-w>H
nnoremap <Esc>J <C-w>J
nnoremap <Esc>K <C-w>K

" Moving in terminal
tnoremap <Esc>L <C-w>L
tnoremap <Esc>H <C-w>H
tnoremap <Esc>J <C-w>J
tnoremap <Esc>K <C-w>K

" Splitting
nnoremap <Esc>x <C-w>s
nnoremap <Esc>v <C-w>v
nnoremap <Esc>c <C-w>c
nnoremap <Esc>o <C-w>o

" Splitting in terminal
tnoremap <Esc>x <C-w>s
tnoremap <Esc>v <C-w>v
tnoremap <Esc>c <C-w>c
tnoremap <Esc>o <C-w>o


" Resizing
nnoremap <Esc>\ <C-w>_ <C-w>\|
nnoremap <Esc>= <C-w>=
nnoremap <Esc><Up> :resize +5<CR>
nnoremap <Esc><Down> :resize -5<CR>
nnoremap <Esc><Left> :vertical resize -5<CR>
nnoremap <Esc><Right> :vertical resize +5<CR>

" Resizing in terminal
tnoremap <Esc>\ <C-w>_ <C-w>\|
tnoremap <Esc>= <C-w>=
tnoremap <Esc><Up> <C-w>:resize +5<CR>
tnoremap <Esc><Down> <C-w>:resize -5<CR>
tnoremap <Esc><Left> <C-w>:vertical resize -5<CR>
tnoremap <Esc><Right> <C-w>:vertical resize +5<CR>

" Tabs management
nnoremap <leader>nt :tabe<CR>

nnoremap <Esc>, :tabprev<CR>
nnoremap <Esc>. :tabnext<CR>
nnoremap <Esc>< :-tabmove<CR>
nnoremap <Esc>> :+tabmove<CR>

" Tabs management in terminal
tnoremap <Esc>, <C-w>:tabprev<CR>
tnoremap <Esc>. <C-w>:tabnext<CR>
tnoremap <Esc>< <C-w>:-tabmove<CR>
tnoremap <Esc>> <C-w>:+tabmove<CR>

" Terminal hotkey

nnoremap <leader>te :split \| term<CR>

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
colorscheme gruvbox

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
nnoremap <leader>gl :GitGutterLineHighlightsToggle<CR>

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

" Bookmarks setup

let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
let g:bookmark_sign = '=>'
let g:bookmark_display_annotation = 1

