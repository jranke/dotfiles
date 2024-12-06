" vimrc of Johannes Ranke
" Last Change: Fri Dec 06, 2024 at 01:12 PM +0100
" default settings (much is handled by tpope/sensible) {{{1
set ts=2
set sw=2
set expandtab
set modeline
filetype plugin on
filetype indent on
set splitbelow
set splitright
set mouse=a
set guicursor=
set hid "que to slow buffer switching, see https://github.com/neovim/neovim/issues/4524

" to ease the use of plugin mappings
let maplocalleader = ","
let mapleader = ";"

" lilypond runtime (https://wiki.debian.org/LilyPond)
set runtimepath+=/usr/share/lilypond/2.22.0/vim/

" Plugins managed by vim-plug {{{1
call plug#begin('~/.vim/plugged')

" The basics
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-scriptease' " gives me K for looking up docs in vim scripts
Plug 'hrp/EnhancedCommentify'
Plug 'vim-scripts/DeleteTrailingWhitespace'
"Plug 'jranke/lastchange.vim', { 'branch': 'jranke' }

" Appearance
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'jalvesaq/R-Vim-runtime'
Plug '~/git/R-Vim-runtime'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
" The following plugin gives me <Leader>bd for closing a buffer while keeping
" the window open, for example when editing several R scripts with
" the R interpreter running in a separate vim window
Plug 'seb-mueller/kwbdi.vim'

" Version control
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter', { 'branch': 'main' }
Plug 'samoshkin/vim-mergetool'
let g:mergetool_layout = 'mr'
let g:mergetool_prefer_revision = 'local'

" File system exploration
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf'

" Bracketed paste
Plug 'ConradIrwin/vim-bracketed-paste'

" Show and manage marks
Plug 'kshenoy/vim-signature'

" Wayland clipboard
Plug 'jasonccox/vim-wayland-clipboard'

" vimcmdline plugin {{{1
Plug 'jalvesaq/vimcmdline'
let cmdline_map_start = '<LocalLeader>s'

" R plugin {{{1
Plug 'jalvesaq/Nvim-R'
vmap r <Esc>:call SendSelectionToR("echo", "down")<CR>
let R_assign = 0
let R_pdfviewer = 'okular'
let R_openpdf = 1
let R_min_editor_width = 100
let R_rconsole_width = 80
let R_debug = 1
let R_dbg_jump = 1
let R_nvim_wd = 1 " set working dir to vims working dir

" The following is taken from issue https://github.com/jalvesaq/Nvim-R/issues/476
function StartRFromPath(path)
    let g:R_path = a:path
    call StartR("R")
endfunction

nmap ,rx :call StartRFromPath('/home/jranke/svn/R/r-devel/build/bin')<CR>
nmap ,ry :call StartRFromPath('/home/jranke/svn/R/r-4-1/build/bin')<CR>

" julia
Plug 'JuliaEditorSupport/julia-vim'

call plug#end()

" R syntax {{{1
let r_syntax_folding = 0
let rmd_syn_hl_chunk = 1
let r_indent_align_args = 0
" The following only has effect if vim-pandoc-syntax is disabled
let g:rmd_fenced_languages = ['r', 'python']
let g:markdown_fenced_languages = ['r', 'python']

" Showmarks {{{1
let marksCloseWhenSelected = 0
let showmarks_include="abcdefghijklmnopqrstuvwxyz"

" Syntax folding for tex and markdown {{{1
" for syntax/tex.vim
let g:tex_fold_enabled=1
" for syntax/markdown.vim
let g:rmd_syn_fold=1

" Beamer/tex environments - should go to some after/tex.vim script {{{1
noremap \bb i\begin{block}{}<CR><CR>\end{block}<CR><ESC>3k14li
noremap \bc i\begin{center}<CR><CR>\end{center}<CR><ESC>2ki
noremap \bf i\begin{frame}{}<Space>%{{{3<CR><CR>\end{frame}<CR><ESC>3k14li
noremap \bi i\begin{itemize}[<+->]<CR>\item <CR>\end{itemize}<ESC>k8li
noremap \bo i\begin{columns}<CR>\begin{column}{.5\textwidth}<CR>\end{column}<CR>\begin{column}{.5\textwidth}<CR>\end{column}<CR>\end{columns}<CR><ESC>6ki
noremap \bs i\source{}<ESC>li
noremap \bt i\begin{tabular}{}<CR><CR>\end{tabular}<CR><ESC>3k$i
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
" Mappings for easier navigation of windows {{{1
" From :help terminal-emulator-input in neovim
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
if has('nvim')
  tnoremap <A-h> <C-\><C-n><C-w>h
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l
endif
colorscheme desert
" XML editing
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax
" {{{1 vim: foldmethod=marker foldlevel=0 ts=2 sw=2 expandtab
