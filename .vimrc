filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
syntax on

" Defaults
source $VIMRUNTIME/defaults.vim

" Wildmenu
set wildmenu

" Relative line numbers
set relativenumber

" Show line number by default
set nu

" A better %
packadd! matchit

" Shortcut for dealing buffers without additional plugins
nnoremap <leader>bf :buffers<CR>:buffer

" Netrw setup
let g:netrw_banner = 0
let g:netrw_liststyle = 2

" FZF
set rtp+=/usr/local/opt/fzf

let g:fzf_layout = { 'down': '40%' }

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

nnoremap <Space>j :Buffers<CR>
nnoremap <Space>k :GFiles<CR>
nnoremap <Space>f :Files<CR>
nnoremap <Space>a :Ag<Space>
nnoremap <Space>a :Ag<Space>
nnoremap <Space>ga :Ag<Space><CR>

" An easy way to leave insert mode
inoremap jj <ESC>

" Commands for inserting empty lines
nnoremap <Space>O O<Esc>
nnoremap <Space>o o<Esc>

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
nnoremap <Space><Space> :noh<CR>

" Golden Ratio
let g:golden_ratio_autocommand = 0
noremap <Space>g :GoldenRatioToggle<CR>

" No wrap!
set nowrap

" Quick fix list keybindings

nnoremap QL :lopen<CR>
nnoremap QQ :copen<CR>
nnoremap f :lnext<CR>
nnoremap b :lprev<CR>
nnoremap p :cprev<CR>
nnoremap n :cnext<CR>

" Windows Management

" Jumping
nnoremap l <C-w>l
nnoremap h <C-w>h
nnoremap j <C-w>j
nnoremap k <C-w>k
nnoremap w <C-w><C-w>
nnoremap q <C-w>W

nnoremap <C-j> 6j
nnoremap <C-k> 6k
nnoremap <C-h> 12h
nnoremap <C-l> 12l

" Moving
nnoremap L <C-w>L
nnoremap H <C-w>H
nnoremap J <C-w>J
nnoremap K <C-w>K

" Splitting
nnoremap x <C-w>s
nnoremap v <C-w>v
nnoremap c <C-w>c
nnoremap o <C-w>o

" Resizing
nnoremap \ <C-w>_ <C-w>\|
nnoremap = <C-w>=
nnoremap <Up> :resize +5<CR>
nnoremap <Down> :resize -5<CR>
nnoremap <Left> :vertical resize -5<CR>
nnoremap <Right> :vertical resize +5<CR>

" Tabs management

nnoremap , :tabprev<CR>
nnoremap . :tabnext<CR>
nnoremap < :-tabmove<CR>
nnoremap > :+tabmove<CR>
nnoremap <Space>nt :tabe<CR>

" Terminal hotkey

nnoremap <Space>tt :term<CR>

" Colorscheme
colorscheme gruvbox8

" Jump to the last insert
noremap <Space>i '^
noremap <Space>I '.

" Change the default splits

set splitbelow splitright

" Insert space
nnoremap <Space>s i<Space><Esc>
nnoremap <Space>S a<Space><Esc>

" Split the line

nnoremap <Space>x i<CR><Esc>

" Copy current file path, name

nnoremap <Space>cf :let @" = expand("%:t")<CR>
nnoremap <Space>cp :let @" = expand("%")<CR>

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'roman/golden-ratio'
Plug 'airblade/vim-gitgutter'

call plug#end()
