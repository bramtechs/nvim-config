set number
set nowrap
set linebreak
set ff=unix

set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set guicursor:
set hidden
set noerrorbells
set smartcase
set nu
set scrolloff=8
set nohlsearch

set noswapfile
set undodir=~/.vim/undodir
set undofile
set nobackup
set nowritebackup

set incsearch
set ignorecase
set signcolumn=yes
"set colorcolumn=80
set cmdheight=2
set laststatus=2

set updatetime=300
set shortmess+=c

let mapleader = " " 

" allow traversal of wrapped lines
noremap j gj
noremap k gk

nnoremap <leader>ff :GFiles --recurse-submodules<CR>
nnoremap <leader>fF :Files<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fc :Commands<CR>
nnoremap <leader>fL :Lines<CR>
nnoremap <leader>fl :BLines<CR>

nnoremap <F5> :!powershell ./run.ps1<CR>
nnoremap <F2> :tabedit ~/AppData/Local/nvim/init.vim<CR>
nnoremap <A-j> :tabprevious<CR>
nnoremap <A-k> :tabnext<CR>
nnoremap <A-n> :tabnew<CR>
nnoremap <leader><F2> :so $MYVIMRC<CR>
nnoremap <leader>F :Format<CR>
tnoremap <leader><Esc> <C-\><C-n>

" relocate neovim 
nnoremap <leader>r :lcd %:p:h<CR>:!echo Moved instance to %:p:h<CR>

" open built in explorer 
nnoremap <leader>e :Explore<CR>

" open Windows explorer at current dir
nnoremap <leader>E :!explorer %:p:h<CR>

nnoremap <C-x> :x<CR>
nnoremap <F6> :vsplit<CR>:e /tmp/empty<CR>
nnoremap <leader><F6> :split<CR>:e /tmp/empty<CR>

" open terminal
nnoremap t :terminal<CR>i
" open terminal in split
nnoremap <leader>t :vsplit<CR><C-w>l<CR>:terminal<CR>i

nnoremap <leader>td :tabedit TODO.md<CR> 

autocmd FileType markdown setlocal spell spelllang=en_us

call plug#begin()

Plug 'EdenEast/nightfox.nvim'
Plug 'morhetz/gruvbox'

Plug 'junegunn/fzf', { 'do': { -> fzf#install()}}
Plug 'junegunn/fzf.vim'

Plug 'udalov/kotlin-vim'

Plug 'ray-x/go.nvim'
Plug 'ray-x/guihua.lua'

Plug 'vim-scripts/vim-auto-save'

Plug 'andweeb/presence.nvim'

Plug 'chrisbra/Colorizer'

"Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

call plug#end()

let g:seiya_auto_enable=1

"colorscheme nightfox 
highlight Normal ctermbg=NONE guibg=NONE
augroup user_colors
  autocmd!
  autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
augroup END
colorscheme nightfox 

" switch windows
nnoremap <C-z> <C-W>

" auto save
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_no_updatetime = 1  " do not change the 'updatetime' option
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode
let g:auto_save_silent = 1  " do not display the auto-save notification

" markdown specific
runtime markdown

" golang specific
autocmd BufWritePre *.go :silent! lua require('go.format').goimport()
