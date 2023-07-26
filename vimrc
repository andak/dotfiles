" Install vim-plug
" https://github.com/junegunn/vim-plug

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'mfukar/robotframework-vim'
Plug 'tommcdo/vim-kangaroo'
Plug 'peterhoeg/vim-qml'

call plug#end()

inoremap <Esc> <NOP>
inoremap jk <Esc>
tnoremap jk <C-W>N

" Leader
let mapleader = "\<Space>"
" Save with w
nnoremap <Leader>w :w<CR>
" Quit with q
nnoremap <Leader>q :q<CR>

" Disable ex mode
:map Q <Nop>

" ui
syntax on
set nu
set ruler
set wildmenu
set scrolloff=3
set updatetime=500 " Update GitGutter every 500 ms
highlight GitGutterAdd    guifg=#009900 guibg=#073642 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 guibg=#073642 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 guibg=#073642 ctermfg=1

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
nnoremap J 6j
nnoremap K 6k
vnoremap J 6j
vnoremap K 6k

nnoremap L :tabnext<cr>
nnoremap H :tabprevious<cr>
vnoremap L :tabnext<cr>
vnoremap H :tabprevious<cr>

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

" Map k and j with goto definition + tag stack push and pop
" or vim-kangroo and YCM
:nmap <leader>j :KangarooPop<CR>
:nmap <silent> <leader>k :KangarooPush<CR><Plug>(coc-definition)
:nmap <silent> <leader>i :KangarooPush<CR><Plug>(coc-references)
"nmap <silent> gd <Plug>(coc-definition)

" FZF file search with p
nmap <leader>p :FZF<cr>
" FZF file content search with o
nmap <leader>o :Rg<cr>

" Make with c
nnoremap <leader>c :<C-U>make<CR>

" Set Syntax highlighting for SCon{script|struct}
au BufNewFile,BufRead SCons* set filetype=python
au BufNewFile,BufRead wscript set filetype=python
" robot files
autocmd BufNewFile,BufRead *.robot setlocal filetype=robot
autocmd BufNewFile,BufRead *.resource setlocal filetype=robot

" Set 2 space indent when editing YAML
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

" https://vi.stackexchange.com/a/456
fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun

nnoremap <F5> :call TrimWhitespace()<CR>

" For the unlucky ones (windows only);
" Remove ugly vim bars
set hid
set guioptions-=M
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" Always show status line
set laststatus=2

" coc.vim  stuff
"Switch between header and source
:command A :CocCommand clangd.switchSourceHeader
" TextEdit might fail if hidden is not set.
set hidden
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Give more space for displaying messages.
set cmdheight=2
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> U :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

nmap <leader>f <Plug>(coc-codeaction-cursor)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Get rid of the ugly pink background in popups
:highlight Pmenu ctermbg=gray guibg=gray guifg=black ctermfg=black
:highlight CocErrorSign ctermbg=gray guibg=gray guifg=black ctermfg=black
:highlight CocWarningSign ctermbg=gray guibg=gray guifg=black ctermfg=black


" Fix paste bug triggered by the above inoremaps
set t_BE=
