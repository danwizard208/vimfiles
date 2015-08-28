" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
" Pathogen setup
" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = ["ctrlp.vim", "GoldenView.Vim"]
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" Quality of life mappings

" Make Y behave like C and D (screw vi-compatible)
nnoremap Y y$
" Use the system clipboard as the default register
set clipboard=unnamed

" g-Enter for blank line before, Enter for a blank line after,
" g-Ctrl-J to split line here
nnoremap g<CR> moO<Esc>`o
nnoremap <CR> moo<Esc>`o
nnoremap g<C-J> i<CR><Esc>k$
" The above <CR> mapping is undesirable in the cmd window, reset it
autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>

" In insert mode, break undo after each line break; more granular control
inoremap <CR> <C-G>u<CR>

" Default to moving by display lines - allow moving by file lines
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Quicker window navigation - just a chord instead of chord AND sequence
"   Disabled while using dwm.vim
if pathogen#is_disabled("dwm.vim")
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l
else
    " Go to master pane
    nnoremap <space> <C-w>h
endif

" Experimental window resize mappings
"   Unfortunately they're a bit cludgy right now because
"   'standard' vim window resizing is a bit cludgy
if pathogen#is_disabled("dwm.vim")
"   Unecessary with dwm.vim
    windo nnoremap <C-Left> <
    windo nnoremap <C-Right> >
endif
windo nnoremap <C-Up> +
windo nnoremap <C-Down> -

" Command to retile windows - puts them into a master pane + stack
nnoremap <C-t> :windo wincmd K<CR> :wincmd H<CR>

" Quicker tab navigation, using similar mnemonics as windows
" Alt is a pain to press see if there's a better way
nnoremap <A-h> gT
nnoremap <A-l> gt

" Don't use Ex mode, use Q for formatting
noremap Q gq


" UI tweaks
" Enable line numbers -
" as of 7.4 this is relative numbers with absolute on current line
set number
set relativenumber
" Display incomplete commands
set showcmd
" Keep 50 lines of command line history
set history=50
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
" Show the cursor position all the time
set ruler
" Enable mouse, I guess
if has('mouse')
  set mouse=a
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
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

" Highlight matches
set hlsearch
" Add a mapping to clear search highlighting
nnoremap <leader><space> :noh<cr>
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

" Add a mapping to maximize the window when on Windows
if has("win32")
    nnoremap <leader><cr> :simalt ~x<cr>:redraw<cr>
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


" Syntax and search highlighting
syntax on
" Enable file type detection.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on


" Open NERDTree with F2
map <F2> :NERDTreeToggle<CR>
" NERDTree should close when opening a file
let NERDTreeQuitOnOpen=1
" Show line numbers in NERDTree window
let NERDTreeShowLineNumbers=1
" Show the bookmark bar by default
let NERDTreeShowBookmarks=1


" This was in the example vimrc; might happen automatically in vim now?
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif


" With pathogen, need to use included Helptags function
Helptags
