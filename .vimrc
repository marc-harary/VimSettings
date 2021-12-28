filetype plugin indent on

let python_highlight_all=1
let g:ale_linters = {'python': ['flake8', 'pylint']}
set nocompatible
:set expandtab
:set tabstop=4
:set shiftwidth=4
set nu
set pyx=3
set laststatus=2
set colorcolumn=80
highlight ColorColumn ctermbg=DarkBlue
set rtp+=~/.vim/bundle/Vundle.vim
if !has('gui_running')
  set t_Co=256
endif

nnoremap <leader>n :NERDTreeToggle<CR>
map , <leader>
nnoremap X "_x
nnoremap DD "_dd
nnoremap CC "_cc

func! WordProcessor()
  map j gj
  map k gk
  setlocal cc=
  setlocal formatoptions=1
  setlocal noexpandtab
  setlocal wrap
  setlocal linebreak
  setlocal spell spelllang=en_us
  set complete+=s
endfu
com! WP call WordProcessor()

func! RenderLatex()
  :w
  :silent !pdflatex % && open $(echo % | sed 's/tex/pdf/g')
  :redraw!
endfu
com! T call RenderLatex()

func! LISP()
	:set tabstop=2
	:set shiftwidth=2
	:set expandtab
endfu
com! LISP call LISP()

func! Python()
  :w
  :!python %
endfu
com! P call Python()

call vundle#begin()
"Plugin 'powerline/powerline'
Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
"Plugin 'vim-scripts/indentpython.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'junegunn/fzf.vim'
Plugin 'jupyter-vim/jupyter-vim'
Plugin 'chakravala/julia-vim'
"Plugin 'dense-analysis/ale'
call vundle#end()
