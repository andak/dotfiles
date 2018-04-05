" Install vim-plug
" https://github.com/junegunn/vim-plug
"
" Add a post-checkout hook to refresh ctags on git checkout:
"
" echo '#!/bin/sh
" ctags -R . &' > .git/hooks/post-checkout
" chmod +x .git/hooks/post-checkout

let g:neocomplete#enable_at_startup = 1

call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/a.vim'
Plug 'johnsyweb/vim-makeshift'
Plug 'jiangmiao/auto-pairs'


" Themes
Plug 'AlessandroYorba/Alduin'
Plug 'w0ng/vim-hybrid'
Plug 'felixhummel/setcolors.vim'
Plug 'flazz/vim-colorschemes'


call plug#end()

" Slightly darker theme
colorscheme alduin

inoremap <Esc> <NOP>
inoremap jk <Esc>

" Leader
let mapleader = "\<Space>"
" Save with w
nnoremap <Leader>w :w<CR>
" Quit with q
nnoremap <Leader>q :q<CR>

" ui
syntax on
set nu
set ruler
set wildmenu
set scrolloff=3

set colorcolumn=100

" Disable cursor blinking
set guicursor+=a:blinkon0

" Map å to remove highlight after search
nmap å :noh<CR>

" get indenting right
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set cindent
set cinoptions=>1s
filetype plugin indent on
filetype plugin on

" ignore case in searches
"set ignorecase

set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,iso-8859-1

" english
set langmenu=en_US.UTF8
let $LANG = 'en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" resize
nmap <c-w>l :vertical res +20<cr>
nmap <c-w>h :vertical res -20<cr>
nmap <c-w>j :res +20<cr>
nmap <c-w>k :res -20<cr>

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.pyc

" Fast moving, J and K (capital) jumps 4
nnoremap J 4j
nnoremap K 6k
vnoremap J 4j
vnoremap K 6k

set hlsearch
highlight Search ctermbg=LightBlue

" trailing whitespace is evil
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

set noswapfile

set guifont=Lucida\ Console

set tags=./tags;/

"http://stackoverflow.com/questions/327411/how-do-you-prefer-to-switch-between-buffers-in-vim
" " Map ctrl-movement keys to window switching
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

" Easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
nmap s <Plug>(easymotion-s)
nmap s <Plug>(easymotion-s2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" Rainbowparantheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Whitelist YCM conf files
let g:ycm_extra_conf_globlist = ['/path/to/.ycm_extra_conf.py']

" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" Ctags maps: k and j
:nnoremap <leader>j <C-T>
:nnoremap <leader>k <C-]>

" FZF with p
nmap <leader>p :FZF<cr>

" Make with c
nnoremap <leader>c :<C-U>make<CR>

" Clang format with f
map <leader>f :pyf clang-format-3.8.py<cr>

" Set Syntax highlighting for SCon{script|struct}
au BufNewFile,BufRead SCons* set filetype=python
" Set 2 space indent when editing YAML
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

" https://vi.stackexchange.com/a/456
fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun

nnoremap <F5> :call TrimWhitespace()<CR>

" Do not auto pair ', as this is used as
" lifetime specifier in Rust
let g:AutoPairs =  {'(':')', '[':']', '{':'}','"':'"', '`':'`'}

" For the unlucky ones (windows only);
" Remove ugly vim bars
set hid
set guioptions-=M
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
