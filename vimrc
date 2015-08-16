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
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

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

" Enable line numbers - as of 7.4 this is relative numbers and absolute
" on current line
set number
set relativenumber
" Always use a status line
set laststatus=2
" No toolbar in the GUI
set guioptions-=T
set guioptions-=m
set guioptions-=r
" Font
set guifont=Consolas:h11:cANSI

" Open NERDTree with F2
map <F2> :NERDTreeToggle<CR>

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
set autoindent		" always set autoindenting on

" Colorscheme in terminal
if !has('gui_running')
    color relaxedgreen
endif

" Shift-Enter for blank line before, Enter for a blank line after, 
" Ctrl-J to split line here
" nnoremap g<CR> moO<Esc>`o
" nnoremap <CR> moo<Esc>`o
" nnoremap <C-J> i<CR><Esc>k$

" LatexSuite commands
" let g:tex_flavor='latex'
" set grepprg=grep\ -nH\ $*

" command Gh GhciFile

" No need to remember to run helptags anymore
" helptags ~/.vim/doc
