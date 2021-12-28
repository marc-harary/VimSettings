filetype plugin indent on


"basic settings
set nocompatible
set expandtab
set tabstop=4
set shiftwidth=4
set nu
set pyx=3
set laststatus=2
set colorcolumn=80
highlight ColorColumn ctermbg=DarkBlue
set rtp+=~/.vim/bundle/Vundle.vim
if !has('gui_running')
  set t_Co=256
endif


"latex/word processors settings
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
  " enables indentation when line wraps around
  set breakindent
  " indent by an additional 4 characters when line >= 40 characters
  " set breakindentopt=shift:4,min:80,sbr
endfu
com! WP call WordProcessor()
autocmd Filetype tex call WordProcessor()
autocmd Filetype text call WordProcessor()
autocmd Filetype markdown call WordProcessor()

func! RenderLatex()
  w
  if substitute(system('uname'), '\n', '', '') == "Darwin"
    silent !pdflatex % && open $(echo % | sed 's/tex/pdf/g')
  elseif substitute(system('uname'), '\n', '', '') == "Linux"
    silent !pdflatex % && xdg-open $(echo % | sed 's/tex/pdf/g')
  endif
  redraw!
endfu
com! T call RenderLatex()


"LISP settings
func! LISP()
        set tabstop=2
        set shiftwidth=2
        set expandtab
endfu
autocmd Filetype lisp call LISP()


"Python settings
let python_highlight_all=1
let g:ale_linters = {'python': ['flake8', 'pylint']}
func! Python()
  w
  !python %
endfu
autocmd Filetype python com! P call Python()
autocmd Filetype python com! F call flake8#Flake8()


"Vundle plugins
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
"Plugin 'vim-scripts/indentpython.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'junegunn/fzf.vim'
Plugin 'jupyter-vim/jupyter-vim'
Plugin 'chakravala/julia-vim'
"Plugin 'dense-analysis/ale'
call vundle#end()
