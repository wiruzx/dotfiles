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

" Show line number by default
set nu

" A better %
packadd! matchit

" Shortcut for dealing buffers without additional plugins
nnoremap <leader>bf :buffers<CR>:buffer

" Netrw setup
let g:netrw_banner = 0
let g:netrw_altfile = 1
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
nnoremap f :lnext<CR>zz
nnoremap b :lprev<CR>zz
nnoremap p :cprev<CR>zz
nnoremap n :cnext<CR>zz

" Tabs management

nnoremap h :tabprev<CR>
nnoremap l :tabnext<CR>
nnoremap H :-tabmove<CR>
nnoremap L :+tabmove<CR>
nnoremap <Space>nt :tabe<CR>

" Terminal hotkey

nnoremap <Space>tt :term<CR>

" Colorscheme
colorscheme gruvbox8

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'roman/golden-ratio'

call plug#end()
