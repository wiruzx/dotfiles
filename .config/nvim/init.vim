autocmd FileType swift setlocal commentstring=//\ %s

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
syntax on

set path+=**

" Save and exit from insert mode
inoremap  <C-\><C-n>:x<CR>

" Search of word under the cursor
nnoremap ga :Ag<Space><CR>

" Xcodebuild error format
set errorformat=
			\%f:%l:%c:{%*[^}]}:\ error:\ %m,
			\%f:%l:%c:{%*[^}]}:\ fatal\ error:\ %m,
			\%f:%l:%c:\ error:\ %m,
			\%f:%l:%c:\ warning:\ %m,
			\%f:%l:%c:\ fatal\ error:\ %m,
			\%f:%l:\ Error:\ %m,
			\%f:%l:\ error:\ %m,
			\%f:%l:\ fatal\ error:\ %m

" Switch between buffers

nnoremap + :bnext<CR>
nnoremap _ :bprevious<CR>

" Map Backspace to C-^
nnoremap <Backspace> <C-^>

" Tags
set tags=tags

" Clipboard

set clipboard=unnamed

" Disable swap files
set noswapfile

" Dark background by default
set bg=dark

" Setup mouse mode
set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

" Change neovim defaults
set ruler!

" Change grep to ag
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ --vimgrep
    set grepformat^=%f:%l:%c:%m
endif

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

" Disable lines in terminal
if has('nvim')
    autocmd TermOpen * setlocal nonumber norelativenumber
endif

" Wildmenu
set wildmenu
set wildoptions=pum
set wildmode=full:lastused
set wildignore+=**/.git/*
set wildignore+=UIGallery/**
set wildignore+=**/generated/**
set wildignore+=**/Generated/**

" Relative line numbers
set relativenumber

" Show line number by default
set nu



" Fix plug
set rtp+=~/.vim/


" Plugins
call plug#begin('~/.vim/plugged')

Plug 'unblevable/quick-scope'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'roman/golden-ratio'
Plug 'airblade/vim-gitgutter'
Plug 'idbrii/vim-argedit'
Plug 'easymotion/vim-easymotion'
Plug 'gruvbox-community/gruvbox'
Plug 'github/copilot.vim'
Plug 'udalov/kotlin-vim'
Plug 'tpope/vim-commentary'

" ChatGPT integration
" Plug 'nvim-lua/plenary.nvim'
" Plug 'MunifTanjim/nui.nvim'
" Plug 'dpayne/CodeGPT.nvim'

" Another ChatGPT plugin
" Plug 'nvim-telescope/telescope.nvim'
" Plug 'jackMort/ChatGPT.nvim'

" xbase
" Plug 'neovim/nvim-lspconfig'
" Plug 'xbase-lab/xbase', { 'do': 'make install' }
" lua require'xbase'.setup()

call plug#end()

let g:copilot_filetypes = {
      \ 'md': v:true,
      \ 'markdown': v:true,
      \ '': v:true,
      \ }

" A better %
packadd! matchit

" Netrw setup
let g:netrw_banner = 0
let g:netrw_liststyle = 2

" Leader

let mapleader = " "

" FZF
set rtp+=/opt/homebrew/bin/fzf

let g:fzf_layout = { 'down': '50%' }
let g:fzf_preview_window = [ 'up:80%,border-horizontal' ]

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'alt-c': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

command! -bang ProjectFiles call fzf#vim#files('.', fzf#vim#with_preview({'source': "fd '\.swift$' --type f --ignore-file ~/.projectignore" }), <bang>0)

" TODO: Change letters
nnoremap <leader>jf :Buffers<CR>
nnoremap <leader>jd :Tags<CR>
nnoremap <leader>js :BTags<CR>

nnoremap <leader>fj :ProjectFiles<CR>
nnoremap <leader>fk :GFiles<CR>
nnoremap <leader>fl :Files<CR>
nnoremap <leader>f; :GFiles?<CR>

nnoremap <leader>ld :Lines<CR>
nnoremap <leader>lf :BLines<CR>

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
set noincsearch
set nowrapscan

" Save on S
nnoremap S :w<CR>

" Space Space
nnoremap <leader><leader> :BLines<CR>

" Golden Ratio
let g:golden_ratio_autocommand = 0
nnoremap <leader>gr :GoldenRatioToggle<CR>

" No wrap!
set nowrap

" Quick fix list keybindings

nnoremap QL :lopen<CR>
nnoremap QQ :copen<CR>
nnoremap <Esc>p :lprev<CR>
nnoremap <Esc>n :lnext<CR>
nnoremap <Esc>b :cprev<CR>
nnoremap <Esc>f :cnext<CR>

" Terminal hotkey

" nnoremap <leader>te :term<CR>
nnoremap <leader>dj <C-W>s:term<CR>

" Accessing buffer in terminal mode

tnoremap  <C-w>"0

" Leaving everything

inoremap  <C-\><C-n>
tnoremap  <C-\><C-n>
cnoremap  <C-\><C-n>

" Accessing command and search history

nnoremap <leader>dk q:
nnoremap <leader>dl q/

" Colorscheme
colorscheme gruvbox

" Change the default splits

set splitbelow splitright

" Insert space
nnoremap <Leader>ps i<Space><Esc>

" Split the line
nnoremap <leader>px i<CR><Esc>

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

" nnoremap <C-j> 6j
" nnoremap <C-k> 6k
" nnoremap <C-h> 12h
" nnoremap <C-l> 12l

" EasyMotion

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1

vmap <leader>s <Plug>(easymotion-s2)
vmap <C-j> <Plug>(easymotion-j)
vmap <C-k> <Plug>(easymotion-k)
vmap <C-h> <Plug>(easymotion-b)
vmap <C-l> <Plug>(easymotion-w)

nmap <leader>s <Plug>(easymotion-s2)
nmap <C-j> <Plug>(easymotion-j)
nmap <C-k> <Plug>(easymotion-k)
nmap <C-h> <Plug>(easymotion-b)
nmap <C-l> <Plug>(easymotion-w)

" nmap <leader>i <Plug>(easymotion-s)
" nmap <leader>j <Plug>(easymotion-j)
" nmap <leader>k <Plug>(easymotion-k)

" quick-scope

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

