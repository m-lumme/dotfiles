" be iMproved
set nocompatible

" determine filetypes
if has('filetype')
  filetype indent plugin on
endif

" syntax highlighting
if has('syntax')
  syntax on
endif

" enable mouse support
if has('mouse')
  set mouse=a
endif

" improve smootheness of redrawing
set ttyfast

" don't redraw during execution of macros, registers and untyped commands
set lazyredraw

" disable error sounds
" disable visual bell
set noerrorbells
set novisualbell
set vb t_vb=

" enable more powerful backspacing
set backspace=indent,eol,start

" navgiate better over wrapped lines
map <silent> j gj
map <silent> k gk
map <silent> <Up> g<Up>
map <silent> <Down> g<Down>

" set UTF-8 as standard encoding
set encoding=utf-8

" enable better indentation
set autoindent
set smartindent

" better command line completion
set wildmenu

" show partial commands
set showcmd

" disable modelines
set nomodeline

" highlight searches
set hlsearch

" do incremental search - highlight while typing
set incsearch

" use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" make <BS> clear search highlighting
nnoremap <silent> <BS> :nohlsearch<CR><BS>

" display line numbers
set number

" identation
set shiftwidth=4
set softtabstop=4
set expandtab

" be aware of outside changes
set autoread

" return to last edit position when opening files
autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

" map <F2> to toggle line soft wrap
nnoremap <F2> :set wrap! wrap?<CR>
imap <F2> <C-O><F2>

" map <F3> to toggle overlines
let s:overlines = 0
fun! Toggle_overlines()
  if s:overlines == 0
    let s:overlines = 1
    match ErrorMsg '\%>80v.\+'
    echo "  overlines"
  else
    let s:overlines = 0
    match none
    echo "nooverlines"
  endif
endfun

nnoremap <F3> :call Toggle_overlines()<CR>
imap <F3> <C-O><F3>

" map <F4> to toggle list mode
nnoremap <F4> :set list! list?<CR>
imap <F4> <C-O><F4>
