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

nnoremap <Space>j :Buffers<CR>
nnoremap <Space>k :GFiles<CR>
nnoremap <Space>a :Ag<Space>

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

" Save on S
nnoremap S :w<CR>

" Space Space
nnoremap <Space><Space> :noh<CR>

" Golden Ratio
" let g:golden_ratio_autocommand = 0
noremap <Space>g :GoldenRatioToggle<CR>

" Show command output in quickfix window
fun! Runcmd(cmd)
    silent! exe "noautocmd botright pedit ".a:cmd
    noautocmd wincmd P
    set buftype=nofile
    exe "noautocmd r! ".a:cmd
    noautocmd wincmd p
endfun
com! -nargs=1 Runcmd :call Runcmd("<args>")

" No wrap!
set nowrap

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'roman/golden-ratio'

call plug#end()
