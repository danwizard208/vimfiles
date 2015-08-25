" Pathogen setup
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" Modified version of example vimrc from Bram
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
noremap Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Syntax and search highlighting 
syntax on
set hlsearch

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else


endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Stuff I made for myself
"
" localvimrc stuff - might add back
" Don't ask before loading local vimrcs - good for now, might change later.
" let g:localvimrc_ask=0
" Don't run vimrc in a sandbox - seems to break match
" let g:localvimrc_sandbox=0

" Make Y behave like C and D (screw vi-compatible)
nnoremap Y y$

" Use the system clipboard as the default register
set clipboard=unnamed

" Enable line numbers -
" as of 7.4 this is relative numbers with absolute on current line
set number
set relativenumber
" Always use a status line and a tab line
set laststatus=2
set showtabline=2
" No toolbar in the GUI
set guioptions-=T
set guioptions-=m
set guioptions-=r
" Plaintext tab line in the GUI
set guioptions-=e
" Font
set guifont=Consolas:h11:cANSI
" Use the solarized colorscheme, good light/dark most everywhere
colorscheme solarized
" Set to light background by default, and map <F5> to toggle
set background=light
call togglebg#map("<F5>")
" Highlight line cursor is on
set cursorline
" Highlight in 'error' column 80 - try not to extend past this
set colorcolumn=80
" Add a map to clear the colorcolumn when it's distracting
nnoremap <leader>` :set colorcolumn=0<CR>
" Open NERDTree with F2
map <F2> :NERDTreeToggle<CR>
" NERDTree should close when opening a file
let NERDTreeQuitOnOpen=1
" Show line numbers in NERDTree window
let NERDTreeShowLineNumbers=1
" Show the bookmark bar by default
let NERDTreeShowBookmarks=1

" " Use Omni completion
" set ofu=syntaxcomplete#Complete
" autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" " Easytags configuration - don't use until we bugfix
" " let g:loaded_easytags = 1
" let g:easytags_dynamic_files = 2
" let g:easytags_include_members = 1
" let g:easytags_on_cursorhold = 0

" Use spaces instead of tabs, with width 4. Indenting is also width 4. Literal
" tabs are 4. Deleting whitespace deletes by tabs.
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
" Always set autoindenting on
set autoindent

" vim-indent-guides plugin settings
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" Colorscheme in terminal
" if !has('gui_running')
"     color relaxedgreen
" endif

" Shift-Enter for blank line before, Enter for a blank line after, 
" Ctrl-J to split line here
" nnoremap g<CR> moO<Esc>`o
" nnoremap <CR> moo<Esc>`o
" nnoremap <C-J> i<CR><Esc>k$

" LatexSuite commands
" let g:tex_flavor='latex'
" set grepprg=grep\ -nH\ $*

" command Gh GhciFile

" With pathogen, need to use included Helptags function
Helptags

set encoding=utf-8
" Starts scrolling on 2nd line from top/bottom
set scrolloff=2
" Break lines at words
set linebreak
" Sets completion to something sane - see help
set wildmenu
set wildmode=list:longest,full
" Visual flash instead of beep
set visualbell
" Automatically use magic mode for regexen
" doesn't affect substitutions, add a mapping for that
nnoremap / /\v
vnoremap / /\v
" Regexen ignore case unless a capital appears
set ignorecase
set smartcase
" Subsittuions are global in line by default
set gdefault
set incsearch
" When closing a bracket briefly (0.2 seconds) jump to matching one
set showmatch
set matchtime=2
" Add a mapping to clear search highlighting
nnoremap <leader><space> :noh<cr>
" Default to splitting below and to the right
set splitbelow
set splitright
" Since the above makes help default to opening below,
" map F1 to go to help above
nnoremap <F1> :topleft h<space>

" Add a mapping to maximize the window when on Windows
if has("win32")
    nnoremap <leader><cr> :simalt ~x<cr>
endif

" Allow for hidden buffers
"   This can be dangerous, but supposedly if learned to use effectively
"   is very powerful. Also makes Scratch.vim work better
set hidden

" Text formatting options:
"   r: insert comment leader after hitting Enter in insert mode
"   q: format comments
"   n: Recognize numbered lists when formatting
"   1: wrap after 1 letter words instead of before if possible
"   j: Attempt to delete extraneous comment leaders when joinging lines
" Has to be in an autocommand to override ftgpluin defaults
autocmd Filetype * set formatoptions=rqn1j

" Default to moving by display lines - allow moving by file lines
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Select linewise to the end of last pasted text
nnoremap <leader>v V`]

" Quicker window navigation - just a chord instead of chord AND sequence
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Quicker tab navigation, using similar mnemonics as windows
" Alt is a pain to press see if there's a better way
nnoremap <A-h> gT
nnoremap <A-l> gt
