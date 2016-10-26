" vim: foldmethod=marker foldlevel=0 ts=2 sw=2

" default settings (much is handled by tpope/sensible) {{{1
set ts=2
set sw=2
set expandtab
filetype plugin on
filetype indent on

" to ease the use of plugin mappings
let maplocalleader = ","
let mapleader = ";"

" Plugins managed by vim-plug {{{1
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-scriptease' " gives me K for looking up docs in vim scripts
Plug 'hrp/EnhancedCommentify'
Plug 'jalvesaq/R-Vim-runtime'
Plug 'jranke/vim-pandoc', { 'branch': 'rmd' }
Plug 'vim-pandoc/vim-pandoc-syntax'

if !has('nvim')
	Plug 'jranke/Vim-R-plugin' " for my vim version 7.4, legacy plugin not maintained by Jakson any more
else
	Plug 'jalvesaq/Nvim-R'
endif

call plug#end()

" legacy Vim-R-plugin plugin {{{1
if !has('nvim')
	"let vimrplugin_vsplit = 0
	"let vimrplugin_rconsole_width = 100

	"let vimrplugin_pdfviewer = "/usr/bin/okular"
	"let vimrplugin_openpdf = 0
	let vimrplugin_assign = 0
	"let vimrplugin_objbr_place = "script,left"
	let r_syntax_folding = 1
	let rmd_syn_hl_chunk = 1

  let vimrplugin_map_r = 1 " is silent per default, therefore tried
	"vnoremap  r  *@<Esc>:call SendSelectionToR("echo", "down")<CR>
  " but this does not work as expected
else
	vmap r <Esc>:call SendSelectionToR("echo", "down")<CR>
	"let R_source_args = "print.eval = TRUE"
	let R_vsplit = 1
	let R_assign = 0
endif

" R syntax {{{1
let r_syntax_folding = 0
let rmd_syn_hl_chunk = 1

" Search {{{1
set infercase
"set hlsearch
set incsearch

" Showmarks {{{1
let marksCloseWhenSelected = 0
let showmarks_include="abcdefghijklmnopqrstuvwxyz"

" Syntax folding for tex and markdown {{{1
" for syntax/tex.vim
let g:tex_fold_enabled=1
" for syntax/markdown.vim
let g:rmd_syn_fold=1

" Beamer/tex environments - should go to some after/tex.vim script {{{1
noremap \bf i\begin{frame}{}<Space>%{{{3<CR><CR>\end{frame}<CR><ESC>3k14li
noremap \bi i\begin{itemize}[<+->]<CR>\item <CR>\end{itemize}<ESC>k8li
noremap \bc i\begin{center}<CR><CR>\end{center}<CR><ESC>2ki
noremap \bt i\begin{table}\begin{tabular}{}<CR><CR>\end{tabular}\end{table}<CR><ESC>3ki
noremap \bo i\begin{columns}<CR>\begin{column}{}<CR>\end{column}<CR>\end{columns}<CR><ESC>3k17li
noremap \bs i\source{}<ESC>li
noremap \eq i\question[2]<CR>\begin{solution}[2cm]<CR>\end{solution}<CR><ESC>3kA

" EnhancedCommentify {{{1
vmap +  <Plug>Comment
vmap -  <Plug>DeComment

" pandoc {{{1
let pandoc#folding#fold_yaml=1
let pandoc#folding#level=2
let pandoc#folding#fdc=0
let pandoc#syntax#conceal#use=0

" Show syntax highlighting under the cursor {{{1
" http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Show syntax highlighting group in status line 
" http://vim.wikia.com/wiki/Showing_syntax_highlight_group_in_statusline
function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

" Status line {{{1
if has('statusline')
  set statusline=%#Question#                   " set highlighting
  set statusline+=%-2.2n\                      " buffer number
  set statusline+=%#WarningMsg#                " set highlighting
  set statusline+=%f\                          " file name
  set statusline+=%#Question#                  " set highlighting
  set statusline+=%h%m%r%w\                    " flags
  set statusline+=%{strlen(&ft)?&ft:'none'},   " file type
  set statusline+=%{(&fenc==\"\"?&enc:&fenc)}, " encoding
  set statusline+=%{((exists(\"+bomb\")\ &&\ &bomb)?\"B,\":\"\")} " BOM
  set statusline+=%{&fileformat},              " file format
  set statusline+=%{&spelllang},               " language of spelling checker
  set statusline+=%{SyntaxItem()}              " syntax highlight group under cursor
  set statusline+=%=                           " ident to the right
  set statusline+=0x%-8B\                      " character code under cursor
  set statusline+=%-7.(%l,%c%V%)\ %<%P         " cursor position/offset
endif

set laststatus=2
