" vim: foldmethod=marker foldlevel=0 ts=2 sw=2 expandtab
" default settings (much is handled by tpope/sensible) {{{1
set ts=2
set sw=2
set expandtab
set modeline
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
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'

" R plugin {{{2
" for vim versions <= 7.4.1453 use the legacy plugin
" Note that on wheezy, vim is too old even for that
if !has('nvim') && !exists("*job_getchannel")
  Plug 'jcfaria/Vim-R-plugin', { 'commit': 'd726d619f12a10fb5ac7967d373837735cff60f0' }

  let vimrplugin_map_r = 1 " is silent per default, therefore tried
  "vnoremap  r  *@<Esc>:call SendSelectionToR("echo", "down")<CR>
  " but this does not work as expected

  let vimrplugin_assign = 0
  let rmd_syn_hl_chunk = 1
  "let vimrplugin_vsplit = 0
  "let vimrplugin_rconsole_width = 100
  "let vimrplugin_pdfviewer = "/usr/bin/okular"
  "let vimrplugin_openpdf = 0
  "let vimrplugin_objbr_place = "script,left"
else
  Plug 'jalvesaq/Nvim-R'
  vmap r <Esc>:call SendSelectionToR("echo", "down")<CR>
  let R_vsplit = 1
  let R_assign = 0
  let R_pdfviewer = 'okular'
  let R_openpdf = 0
endif
" 2}}}

call plug#end()

" R syntax {{{1
let r_syntax_folding = 0
let rmd_syn_hl_chunk = 1

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
" More info available via mapping zS from tpope/vim-scriptease
" http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Show syntax highlighting group in status line 
" http://vim.wikia.com/wiki/Showing_syntax_highlight_group_in_statusline
function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

" Airline {{{1
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
let g:airline_theme='wombat'
call airline#parts#define_function('syntax', 'SyntaxItem')
let g:airline_section_x=airline#section#create_right(['syntax', 'filetype'])
" Always show statusline {{{1
set laststatus=2
