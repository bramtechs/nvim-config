set number
set nowrap
set linebreak
set ff=unix

set relativenumber
set smartindent
set guicursor:
set hidden
set noerrorbells
set smartcase
set nu
set scrolloff=8
set nohlsearch
set list

set noswapfile
set undodir=~/.vim/undodir
set undofile
set nobackup
set nowritebackup

set incsearch
set ignorecase
set cmdheight=2
set laststatus=2

set updatetime=300
set shortmess+=c

set mousemodel=popup

set updatetime=300
set signcolumn=yes

let mapleader = " " 

" allow traversal of wrapped lines
noremap j gj
noremap k gk

nnoremap <F4> :!powershell ./build.ps1<CR>
nnoremap <F5> :!powershell ./run.ps1<CR>
nnoremap <F2> :tabedit ~/AppData/Local/nvim/init.vim<CR>
nnoremap <F8> :tabedit ~/Documents/TODO.md<CR>zR<CR>
nnoremap <A-j> :tabprevious<CR>
nnoremap <A-k> :tabnext<CR>
nnoremap <A-n> :tabnew<CR>
nnoremap <leader><F2> :so $MYVIMRC<CR>
nnoremap <leader>F :Format<CR>
tnoremap <leader><Esc> <C-\><C-n>

" relocate neovim 
nnoremap <leader>R :lcd %:p:h<CR>:!echo Moved instance to %:p:h<CR>

" open built in explorer 
nnoremap <leader>e :Explore<CR>

" open Windows explorer at current dir
nnoremap <leader>E :!explorer %:p:h<CR>

nnoremap <C-F4> :x<CR>
nnoremap <F6> :vsplit<CR>
nnoremap <leader><F6> :split<CR>

" open terminal
nnoremap T :terminal<CR>i powershell<CR>
" open terminal in split
nnoremap <leader>t :vsplit<CR><C-w>l<CR>:terminal<CR>i powershell<CR>

nnoremap <leader>td :tabedit TODO.md<CR> 

" latex shortcuts
nnoremap <leader>l% i\mathbin{\%}<ESC>
nnoremap <leader>ls i\section{
nnoremap <leader>lS i\subsection{
nnoremap <leader>ld i\begin{document}<ESC>
nnoremap <leader>lD i\end{document}<ESC>
nnoremap <leader>lb i\textbf{
nnoremap <leader>lf i\[  \]<ESC>F[lli

" change line endings to spaces
nnoremap <leader>ts :%s/\t/    /g<CR>

nnoremap <C-p> :Ouroboros<CR>

call plug#begin()

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}

Plug 'EdenEast/nightfox.nvim' "
Plug 'morhetz/gruvbox'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
Plug 'jakemason/ouroboros'

Plug 'udalov/kotlin-vim'

Plug 'ray-x/go.nvim'
Plug 'ray-x/guihua.lua'

Plug 'vim-scripts/vim-auto-save'
Plug 'https://github.com/preservim/vim-markdown.git'

Plug 'andweeb/presence.nvim'

Plug 'chrisbra/Colorizer'

Plug 'nvim-orgmode/orgmode'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

Plug 'folke/zen-mode.nvim'
Plug 'folke/todo-comments.nvim'

Plug 'itchyny/lightline.vim'

Plug 'natecraddock/sessions.nvim'

call plug#end()

let g:seiya_auto_enable=1

colorscheme gruvbox
"colorscheme morning


"highlight Normal ctermbg=NONE guibg=NONE
"augroup user_colors
"  autocmd!
"  autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
"augroup END

" switch windows
nnoremap <C-z> <C-W>

" telescope
lua << EOF
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.git_files, {})
    vim.keymap.set('n', '<leader>fF', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
EOF

" zen mode
lua << EOF
  require("zen-mode").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

" sessions
lua << EOF
require("sessions").setup({
    events = { "RemoteReply" }, -- do nothing
})
EOF

" auto save
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_no_updatetime = 1  " do not change the 'updatetime' option
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode
let g:auto_save_silent = 1  " do not display the auto-save notification

" markdown specific
runtime markdown

" convert org-definition to a markdown one
nnoremap zd xxf:xhi<CR><ESC>

" golang specific
autocmd BufWritePre *.go :silent! lua require('go.format').goimport()

" treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c","java", "lua", "rust", "cpp", "javascript" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = false,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
}
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.haxe = {
  install_info = {
    url = "C:\\dev\\tree-sitter-haxe", -- local path or git repo
    files = {"src/parser.c"},
    -- optional entries:
    branch = "main", -- default branch in case of git repo if different from master
    generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
  filetype = "hx", -- if filetype does not match the parser name
}
EOF

" todo-comments
lua << EOF
  require("todo-comments").setup {
  }
EOF

" lightline status bar
set noshowmode

" almighty COC

" May need for vim (not neovim) since coc.nvim calculate byte offset by count
" utf-8 byte sequence.

set encoding=utf-8
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for apply code actions at the cursor position.
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer.
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for apply refactor code actions.
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

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

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" coc should use these
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
