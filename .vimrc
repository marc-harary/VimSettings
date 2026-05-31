syntax on
filetype plugin indent on

" Basic settings
set foldlevelstart=99
set nocompatible
set expandtab
set tabstop=4
set shiftwidth=4
set nu
set pyx=3
set laststatus=2
set colorcolumn=80
highlight ColorColumn ctermbg=DarkBlue
if !has('gui_running')
  set t_Co=256
endif

" Ensure autocommands don't stack up and duplicate on resourcing
augroup MyWorkspace
  autocmd!

  " Word Processor / LateX Environments
  autocmd Filetype tex,text,markdown call WordProcessor()

  " Python Environments
  autocmd Filetype python com! P call Python()
  autocmd Filetype python com! B call Black()
  autocmd Filetype python com! F call flake8#Flake8()
  autocmd Filetype python setlocal foldmethod=indent

  " Julia Environments
  autocmd Filetype julia com! J call Julia()
augroup END

" Latex/word processors settings
func! WordProcessor()
  " <buffer> isolates the mapping to this file only; noremap prevents loops
  nnoremap <buffer> j gj
  nnoremap <buffer> k gk
  setlocal cc=
  setlocal formatoptions=1
  setlocal noexpandtab
  setlocal wrap
  setlocal linebreak
  setlocal spell spelllang=en_us
  set complete+=s
  set breakindent
endfu
com! WP call WordProcessor()

func! RenderLatex()
  w
  " Clean, bulletproof native Vim path expansion without risky sed string replaces
  let l:pdf_file = expand('%:p:r') . '.pdf'
  
  if substitute(system('uname'), '\n', '', '') == "Darwin"
    execute 'silent !pdflatex % && open ' . shellescape(l:pdf_file)
  elseif substitute(system('uname'), '\n', '', '') == "Linux"
    execute 'silent !pdflatex % && xdg-open ' . shellescape(l:pdf_file)
  endif
  redraw!
endfu
com! T call RenderLatex()

" Python configurations
let python_highlight_all=1
let g:ale_linters = {'python': ['flake8', 'pylint']}

func! Python()
  w
  !python %
endfu

function! Black()
  w
  silent! !black %
  silent! edit!
  redraw!
endfunction

fu! Julia()
  w
  !julia %
endfu
