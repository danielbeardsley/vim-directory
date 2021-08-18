" Pathogen vim plugin loading - https://github.com/tpope/vim-pathogen
call pathogen#infect()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author: Shawn Tice, with lots of help from the internet.

set guioptions=am        " No toolbar in the gui; must be first in .vimrc.
set guifont=Consolas:h9
" encoding settings for gVim
set encoding=utf-8
set fileencoding=utf-8

set nocompatible         " No compatibility with vi.
filetype on              " Recognize syntax by file extension.
filetype indent on       " Check for indent file.
filetype plugin on       " Allow plugins to be loaded by file type.
syntax on                " Syntax highlighting.

set autowrite             " Write before executing the 'make' command.
set background=dark       " Background light, so foreground not bold.
set backspace=2           " Allow <BS> to go past last insert.
set expandtab             " Expand tabs with spaces.
set nofoldenable          " Disable folds; toggle with zi.
set gdefault              " Assume :s uses /g.
set ignorecase            " Ignore case in regular expressions
set incsearch             " Immediately highlight search matches.
set modeline              " Check for a modeline.
set noerrorbells          " No beeps on errors.
set nowrap                " Don't soft wrap.
set number                " Display line numbers.
set ruler                 " Display row, column and % of document.
set scrolloff=6           " Keep min of 6 lines above/below cursor.
set shiftwidth=3          " >> and << shift 3 spaces.
set showcmd               " Show partial commands in the status line.
set showmatch             " Show matching () {} etc..
set showmode              " Show current mode.
set smartcase             " Searches are case-sensitive if caps used.
set softtabstop=3         " See spaces as tabs.
set tabstop=3             " <Tab> move three characters.
set textwidth=79          " Hard wrap at 79 characters.
set virtualedit=block     " Allow the cursor to go where there's no char.
set wildmode=longest,list " Tab completion works like bash.
set complete=.,w,b,t      " Tab completion settings
set spelllang=en_us       " This is Umurica!

set wildignore+=*.log
set wildignore+=Logs/**
set wildignore+=**/.git/**
set wildignore+=**/node_modules/**
set wildignore+=**/vendor/**

" Live dangerously
set nobackup
set nowritebackup
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set some configuration variables.

let loaded_matchparen=0   " do automatic bracket highlighting.
let mapleader=","         " Use , instead of \ for the map leader.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Formatting settings

" t: Auto-wrap text using textwidth. (default)
" c: Auto-wrap comments; insert comment leader. (default)
" q: Allow formatting of comments with "gq". (default)
" r: Insert comment leader after hitting <Enter>.
" o: Insert comment leader after hitting 'o' or 'O' in command mode.
" n: Auto-format lists, wrapping to text *after* the list bullet char.
" l: Don't auto-wrap if a line is already longer than textwidth.
set formatoptions+=ron
set nojoinspaces          " Don't Condense '.  ' -> '. ' whne joining lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command-line cartography

" Command-line editing more like bash/emacs.
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <C-U> <C-E><C-U>

" Stupid shift mistakes.
:command! W w
:command! Q q
:command! Qa qa

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command mode cartography

" Make Q reformat text.
noremap Q gq

" Toggle paste mode.
noremap <Leader>p :set paste!<CR>

" Open the file under the cursor in a new tab.
noremap <Leader>ot <C-W>gf

" Toggle highlighting of the last search.
noremap <Leader>h :set hlsearch! hlsearch?<CR>

" Open a scratch buffer.
noremap <Leader>s :Scratch<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Insert mode cartography

" Set up dictionary completion.
set dictionary+=~/.vim/dictionary/english-freq
set complete+=k

" Don't scan included files, it's slow!!!!
set complete-=i

" Insert <Tab> or complete identifier if the cursor is after a keyword
" character.
function! TabOrComplete()
    let col = col('.')-1
    if !col || getline('.')[col-1] !~ '\k'
        return "\<tab>"
    else
        return "\<C-N>"
     endif
endfunction
inoremap <Tab> <C-R>=TabOrComplete()<CR>


" Make C-s write the buffer and return to insert mode when applicable
inoremap <C-s> <C-O>:w<CR>
nnoremap <C-s> :w<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlighting

syntax enable
" This should automatically be determined from the terminal type...
set t_Co=16
colorscheme solarized

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic options : https://github.com/scrooloose/syntastic/

let g:syntastic_check_on_open=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Restore the cursor when we can.

function! RestoreCursor()
    if line("'\"") <= line("$")
        normal! g`"
        normal! zz
    endif
endfunction
autocmd BufWinEnter * call RestoreCursor()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My Customizations

set path=./**

" Reread configuration of Vim if .vimrc is saved {{{
augroup VimConfig
  au!
  autocmd BufWritePost ~/.vimrc       so ~/.vimrc
  autocmd BufWritePost _vimrc         so ~/_vimrc
  autocmd BufWritePost vimrc          so ~/.vimrc
augroup END
" }}}

" Since I hardly ever need to type jk this is fast.
imap jk <Esc>
imap kj <Esc>

" auto-insert second braces and parynthesis
inoremap {<CR> {<CR>}<Esc>O
inoremap ({<CR> ({<CR>});<Esc>O
inoremap <<<<CR> <<<EOT<CR>EOT;<Esc>O<C-TAB><C-TAB><C-TAB>
set cpoptions+=$ "show dollar sign at end of text to be changed

" Allow easy toggling of spaces / tabs mode
nnoremap <C-t><C-t> :set invexpandtab<CR>

" Create simple toggles for line numbers, paste mode, word wrap, ...
" nnoremap <C-N><C-N> :set invnumber<CR>
nnoremap <C-p><C-p> :set invpaste<CR>
nnoremap <C-w><C-w> :set invwrap<CR>
nnoremap <leader><C-s> :set invspell<CR>

" Use C-hjkl in to change windows
nnoremap <C-h> <C-w><Left>
nnoremap <C-j> <C-w><Down>
nnoremap <C-k> <C-w><Up>
nnoremap <C-l> <C-w><Right>

" Split windows with sanity
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <C-w>s <C-w>s<C-w>j

" Folding stuff
set foldmethod=indent

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Background setting
nnoremap <leader><C-d> :set background=dark<CR>
nnoremap <leader><C-l> :set background=light<CR>

"==========================================
" vim-powerline: https://github.com/Lokaltog/vim-powerline
let g:Powerline_theme="solarized"
let g:Powerline_symbols="compatible"
" show status line even where there is only one window
set laststatus=2

"==========================================
" vim-indent-guides : 
"hi IndentGuidesOdd  ctermbg=black
"hi IndentGuidesEven ctermbg=darkgrey
"hi IndentGuidesOdd  ctermbg=white
"hi IndentGuidesEven ctermbg=lightgrey

"==========================================
" Mouse Options

" Enable mouse scrolling in all modes!
set mouse=a

"==========================================
" From: https://gist.github.com/3882918
" Author: Marc Zych
nnoremap <silent> <C-o> :call FindFile()<CR>

function! FindFile()
   " Get the word under cursor.
   let cursorWord = expand("<cword>")
   " Get the current file name and keep only the extension.
   let currentFile = expand("%")
   let extPos = strridx(currentFile, ".")

   " Append an extension only if the current file has an extension.
   if extPos != -1
      let extension = strpart(currentFile, extPos)
   else
      let extension = ""
   endif

   " Construct the file name.
   let fileName = cursorWord.extension

   " Open the file in the current buffer.
   execute ":find ".fileName
endfunction
"==========================================
"
"==========================================
"pman - php man pages.
set keywordprg=pman

" fzf fuzzy finder
set rtp+=/usr/share/nvim/site/plugin/fzf.vim
nnoremap <Leader>f :FZF<CR>

" open the quickfix window for the results of grep commands
autocmd QuickFixCmdPost *grep* cwindow

"==========================================
" vim-plug Plugin manager
call plug#begin('~/.vim/plugged')

Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
Plug 'peitalin/vim-jsx-typescript'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

call plug#end()

" set filetypes as typescriptreact
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

let g:ale_linters = { 'php': ['phpcs', 'psalm'] }
