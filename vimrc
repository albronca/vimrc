" Leader
let mapleader = " "

set backspace=2   " backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " always display the status line
set autowrite     " automatically :write before running commands

" theme
set background=dark
colorscheme gruvbox
set guifont=Menlo\ Regular:h18
set encoding=utf-8
syntax on
filetype plugin indent on

" airline
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1

" ale
let g:ale_set_highlights = 0

" fzf
set rtp+=/usr/local/opt/fzf
nnoremap <Leader>f :FZF<CR>

" ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
nnoremap <Leader>a :Ack! 
vnoremap <Leader>a y:Ack! <C-R>"<CR>

" NERDTree
nnoremap <silent> <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <C-m> :NERDTreeFind<CR>
let NERDTreeQuitOnOpen=1
let NERDTreeMinimalUI=1

" Unhighlighted search matches
nnoremap <silent> <C-c> :noh<CR>

" NERDCommenter
let g:NERDSpaceDelims = 1

" softtabs, 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" 80 character line
set textwidth=80
set colorcolumn=+1

" Line numbers
set number
set numberwidth=5
set relativenumber

" More natural splits
set splitbelow
set splitright

" Quicker split navigation
function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr())
    if (match(a:key,'[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction

nnoremap <silent> <C-h> :call WinMove('h')<CR>
nnoremap <silent> <C-j> :call WinMove('j')<CR>
nnoremap <silent> <C-k> :call WinMove('k')<CR>
nnoremap <silent> <C-l> :call WinMove('l')<CR>

" Scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" sometimes it's ok to use a mouse
nnoremap <Leader>mon :set mouse=a<CR>
nnoremap <Leader>moff :set mouse=<CR>

" Show matching bracket or parenthesis
set showmatch

" Highlight search matches
set hlsearch

" elm-format
let g:elm_format_autosave = 1

" JSX
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0

" autocmd stuff
if has("autocmd")
  " delete fugitive buffers after closing
  autocmd BufReadPost fugitive://* set bufhidden=delete

  " quit if NERDTree is the only open buffer
  autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

  " remove trailing whitespace on buffer write for specified filetypes
  autocmd BufWritePre *.rb,*.js,*.jsx :call <SID>StripTrailingWhitespaces()

  " open NERDTree if no file specified
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
endif

function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
