" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Pathogen setup"{{{
" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled =
            \["GoldenView.Vim", "dwm.vim"]
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
"}}}

" Quality of life mappings"{{{

" Make Y behave like C and D (screw vi-compatible)
nnoremap Y y$
" Use the system clipboard as the default register
set clipboard=unnamed

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
" nnoremap <A-h> gT
" nnoremap <A-l> gt
" it looks like I have to use the result of  to map these alt-keys
nnoremap è gT
nnoremap ì gt

" Don't use Ex mode, use Q for formatting
noremap Q gq

" Use H and L for in-line movement, put their old functions under leader
nnoremap H ^
nnoremap L $
nnoremap <leader>H H
nnoremap <leader>L L

" Sets completion to something sane - see help
set wildmenu
set wildmode=list:longest,full

" Count number of times last search matches in the buffer
nnoremap <leader>n :%s///n<CR>

" Seemless editing restoration"{{{
set undofile
set undodir-=.
if has("win32")
    set undodir+=~/vim_undo
else
    set undodir+=~/.vim_undo
endif
"}}}

autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
"}}}

" UI tweaks"{{{

" On-screen information"{{{
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
" Highlight line cursor is on
set cursorline
" Highlight column 80 - try not to extend past this
set colorcolumn=80
" Add a map to clear the colorcolumn when it's distracting
nnoremap <silent> <leader>` :set colorcolumn=0<CR>
" Show the cursor position all the time
set ruler
" Visual flash instead of beep
set visualbell
" Don't put hunk-diff information in airline status bar
let g:airline#extensions#hunks#enabled = 0
" Maps to check for and zap trailing whitespace
nnoremap <silent> <leader>w :match ErrorMsg /\v\s+$/<cr>
nnoremap <silent> <leader>W     mw:silent %s/\v\s+$//<cr>`w
" Maps to toggle and refresh whitespace checking in airline
nnoremap <silent> <leader>a :AirlineToggleWhitespace<cr>
nnoremap <silent> <leader>A
            \ :AirlineToggleWhitespace<cr>:AirlineToggleWhitespace<cr>
"}}}

" GUI {{{
" No toolbar in the GUI
set guioptions-=T
set guioptions-=m
set guioptions-=r
" Plaintext tab line in the GUI
set guioptions-=e
"}}}

" Font"{{{
if has("win32")
    set guifont=Droid_Sans_Mono_for_Powerline:h12
    let g:airline_powerline_fonts=1
endif
let g:airline_powerline_fonts=1
"}}}

" Use the solarized colorscheme, good light/dark most everywhere
colorscheme solarized
" Set to light background by default, and map <F5> to toggle
set background=light
call togglebg#map("<F5>")

if has('mouse')
  set mouse=a
endif
set encoding=utf8
" Starts scrolling on 2nd line from top/bottom
set scrolloff=1
" Break lines at words
set linebreak

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"Tabs and indents"{{{
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
"}}}

"Search "{{{

" Highlight matches
set hlsearch
" Add a mapping to clear search highlighting
nnoremap <silent> <leader><space> :noh<cr>
" Automatically use magic mode for regexen
" doesn't affect substitutions, add a mapping for that
nnoremap / /\v
vnoremap / /\v
" Regexen ignore case unless a capital appears
set ignorecase
set smartcase
" Substitutions are global in line by default
set gdefault
set incsearch
" When closing a bracket briefly (0.2 seconds) jump to matching one
set showmatch
set matchtime=2
"}}}

" Add a mapping to maximize the window when on Windows
if has("win32")
    nnoremap <leader><cr> :simalt ~x<cr>:redraw<cr>
endif

" More natural splits
set splitbelow
set splitright

" Not using hidden buffers for now, too complicated
" set hidden


" Syntax and search highlighting
syntax on
" Enable file type detection.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
"}}}

" Text formatting options:"{{{
"   r: insert comment leader after hitting Enter in insert mode
"   q: format comments
"   n: Recognize numbered lists when formatting
"   1: wrap after 1 letter words instead of before if possible
"   j: Attempt to delete extraneous comment leaders when joinging lines
" Has to be in an autocommand to override ftgpluin defaults

augroup format
    autocmd!
    autocmd Filetype * set formatoptions=rqn1j
augroup END
"}}}

" NERDTree"{{{
" Open NERDTree with F2
map <F2> :NERDTreeToggle<CR>
" NERDTree should close when opening a file
let NERDTreeQuitOnOpen=1
" Show line numbers in NERDTree window
let NERDTreeShowLineNumbers=1
" Show the bookmark bar by default
let NERDTreeShowBookmarks=1
"}}}

" With pathogen, need to use included Helptags function
Helptags
