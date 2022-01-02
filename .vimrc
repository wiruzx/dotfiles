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

" Disable netrw help
let g:netrw_banner=0

" FZF
set rtp+=/usr/local/opt/fzf
nnoremap <C-j> :Bu<CR>
nnoremap <C-k> :GFiles<CR>
nnoremap <C-h> :Ag

" An easy way to leave insert mode
inoremap jj <ESC>

" Commands for inserting empty lines
nnoremap <C-p> O<Esc>
nnoremap <C-n> o<Esc>

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

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()
