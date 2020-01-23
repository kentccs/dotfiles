" .vimrc
" See: http://vimdoc.sourceforge.net/htmldoc/options.html for details

" For multi-byte character support (CJK support, for example):
"set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,gb18030,latin1
       
execute pathogen#infect()

set tabstop=4       " Number of spaces that a <Tab> in the file counts for.
 
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent.
 
set expandtab       " Use the appropriate number of spaces to insert a <Tab>.
                    " Spaces are used in indents with the '>' and '<' commands
                    " and when 'autoindent' is on. To insert a real tab when
                    " 'expandtab' is on, use CTRL-V <Tab>.
 
set smarttab        " When on, a <Tab> in front of a line inserts blanks
                    " according to 'shiftwidth'. 'tabstop' is used in other
                    " places. A <BS> will delete a 'shiftwidth' worth of space
                    " at the start of the line.
 
set showcmd         " Show (partial) command in status line.

set number          " Show line numbers.

set showmatch       " When a bracket is inserted, briefly jump to the matching
                    " one. The jump is only done if the match can be seen on the
                    " screen. The time to show the match can be set with
                    " 'matchtime'.
set foldmethod=syntax

set hlsearch        " When there is a previous search pattern, highlight all
                    " its matches.
 
set incsearch       " While typing a search command, show immediately where the
                    " so far typed pattern matches.
 
set ignorecase      " Ignore case in search patterns.
 
set smartcase       " Override the 'ignorecase' option if the search pattern
                    " contains upper case characters.
 
set backspace=2     " Influences the working of <BS>, <Del>, CTRL-W
                    " and CTRL-U in Insert mode. This is a list of items,
                    " separated by commas. Each item allows a way to backspace
                    " over something.
 
set autoindent      " Copy indent from current line when starting a new line
                    " (typing <CR> in Insert mode or when using the "o" or "O"
                    " command).
 
set textwidth=99    " Maximum width of text that is being inserted. A longer
                    " line will be broken after white space to get this width.
 
set formatoptions=c,q,r,t " This is a sequence of letters which describes how
                    " automatic formatting is to be done.
                    "
                    " letter    meaning when present in 'formatoptions'
                    " ------    ---------------------------------------
                    " c         Auto-wrap comments using textwidth, inserting
                    "           the current comment leader automatically.
                    " q         Allow formatting of comments with "gq".
                    " r         Automatically insert the current comment leader
                    "           after hitting <Enter> in Insert mode. 
                    " t         Auto-wrap text using textwidth (does not apply
                    "           to comments)
 
set ruler           " Show the line and column number of the cursor position,
                    " separated by a comma.
 
set background=dark " When set to "dark", Vim will try to use colors that look
                    " good on a dark background. When set to "light", Vim will
                    " try to use colors that look good on a light background.
                    " Any other value is illegal.
 
"set mouse=a         " Enable the use of the mouse.

set wildmenu       " visual autocomplete for command menu

set laststatus=2 "show airline statusline all the time
 
filetype plugin indent on
syntax on
"colorscheme solarized
let g:pymode_options_colorcolumn = 0
let g:pymode_warnings = 1
let g:pymode_trim_whitespaces = 1
let g:pymode_lint_ignore="E501"
let g:flake8_show_in_file=1
let g:flake8_show_quickfix=0
map <Esc><Esc> :w<CR>
let Tlist_Compact_Format = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
nnoremap <C-l> :TlistToggle<CR>
let g:C_UseTool_cmake    = 'yes'
let g:C_UseTool_doxygen  = 'yes'
autocmd BufWritePost *.py call Flake8()

# New Changes
# ============

"{{{ Vi-nocompatible

set nocompatible

"}}}

"{{{ Leader key

let mapleader = " " 

"}}}

"{{{ Plugins

"{{ Load plugin manager

if !filereadable(expand('~/.vim/autoload/plug.vim'))
    let s:first_init=1
endif

if exists("s:first_init")
    echom 'Plugin manager: vim-plug not been installed. Attempting installation...'
    exec 'silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs '.
            \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    echom 'Installed successfully!'
endif

call plug#begin('~/.vim/plugged')

"}}

"{{ Intellisense and autocomplete

Plug 'neoclide/coc.nvim', {'branch': 'release'}
  let g:coc_global_extensions = ['coc-json', 'coc-tsserver', 'coc-tslint', 'coc-prettier']
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

"}}

"{{ Colorschemes

" Load colorscheme
Plug 'morhetz/gruvbox'

  " Use the default gruvbox contrast level
  let g:gruvbox_contrast_dark='default'

"}}

"{{ Version control - Git
  
" Git integration on normal mode
Plug 'tpope/vim-fugitive'

" Gutter showing git changes
Plug 'airblade/vim-gitgutter'

" Nerd tree showing git changes
Plug 'Xuyuanp/nerdtree-git-plugin'
"}}

"{{ Language syntax helpers

" Dart
Plug 'dart-lang/dart-vim-plugin'

" JavaScript
Plug 'pangloss/vim-javascript'

"Plug 'chemzqm/vim-jsx-improve'
Plug 'maxmellon/vim-jsx-pretty'
  highlight def link jsxTag Identifier
  highlight def link jsxTagName Identifier
  highlight def link jsxComponentName Identifier

  highlight def link jsxAttrib Include
  highlight def link jsxAttribKeyword jsxAttrib
  highlight def link jsxString String
  highlight def link jsxComment Comment

  highlight def link jsxDot Operator
  highlight def link jsxNamespace Operator
  highlight def link jsxEqual Operator
  highlight def link jsxSpreadOperator Operator
  highlight def link jsxBraces Operator

" GraphQL
Plug 'jparise/vim-graphql'


" C++
Plug 'octol/vim-cpp-enhanced-highlight'
  let g:cpp_class_scope_highlight = 1
  let g:cpp_member_variable_highlight = 1
  let g:cpp_class_decl_highlight = 1
  let g:cpp_experimental_template_highlight = 1
  let g:cpp_concepts_highlight = 1

" GLSL
Plug 'tikhomirov/vim-glsl'

" Close braces and brackets
Plug 'jiangmiao/auto-pairs'

" Close XML tags
Plug 'alvan/vim-closetag'
  let g:closetag_filenames = '*.html,*.xhtml,*.xml,*.vue,*.phtml,*.js,*.jsx,*.coffee,*.erb'

"}}


"{{ Navigation

" Project file tree
Plug  'scrooloose/nerdtree'
  
  " Show hidden files
  let g:NERDTreeShowHidden=1

  let g:NERDTreeMouseMode=3

  " Hide these files
  let g:NERDTreeIgnore = [ '__pycache__',  '\.pyc$', '\.o$', '\.swp', '*\.swp', 'node_modules/' ]
  
  " Autostart NERDTree on starting Vim
  autocmd vimenter * NERDTree
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:stdn_in") | NERDTree | endif

  " Toggle NERDTree
  map <silent> <C-n> :NERDTreeToggle<CR>

  map <silent> <leader>r :NERDTreeFind<cr>

  " Folder name color same as folder icon
  highlight! link NERDTreeFlags NERDTreeDir

" TMUX-Vim integration
Plug 'christoomey/vim-tmux-navigator'

" Maximize active pane
Plug 'zhaocai/GoldenView.Vim'
  
  " Disable default mapping
  let g:goldenview__enable_default_mapping = 0

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }

" Fuzy finder Vim integration
Plug 'junegunn/fzf.vim'
  
  " Prepend all fzf commands to avoid pollution
  let g:fzf_command_prefix = 'Fzf'

  " Git commits
  nnoremap <silent> <leader>c :FzfCommits<CR>
  
  " Search within project
  nnoremap <silent> <leader>f :FzfAg<CR>
  
  " Search filenames
  nnoremap <silent> <leader>F :FzfFiles<CR>

  " Show file preview in fzf
  command! -bang -nargs=? -complete=dir FzfFiles
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
  command! -bang -nargs=* FzfAg
    \ call fzf#vim#ag(<q-args>,
    \                 <bang>0 ? fzf#vim#with_preview('up:60%')
    \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
    \                 <bang>0)

" Global search allowing navigation from file to file
Plug 'dyng/ctrlsf.vim'
  let g:ctrlsf_auto_focus = { 'at': 'start' }
  let g:ctrlsf_mapping = { 'next': 'n',  'prev': 'N'  }
  let g:ctrlsf_position = 'bottom'
  nnoremap <leader>s viw :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
  "nnoremap <leader>s :<C-u>set operatorfunc=<SID>GrepFromSelected<CR>g@

  function! s:GrepFromSelected(type)
    let saved_unnamed_register = @@
    if a:type ==# 'v'
      normal! `<v`>y
    elseif a:type ==# 'char'
      normal! `[v`]y
    else
      return
    endif
    let word = substitute(@@, '\n$', '', 'g')
    let word = escape(word, '| ')
    let @@ = saved_unnamed_register
    execute 'CtrlSF '.word
  endfunction
" }}


Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'

"}}


"{{ Extras

" Cool status bar
Plug 'bling/vim-airline'

  " ...with cool fonts
  let g:airline_powerline_fonts=1

" Cool file icons (important: load as last!)
Plug 'ryanoasis/vim-devicons'

"}}

" Install all plugins if this is the firs load
if exists('s:first_init')
  PlugInstall
end

call plug#end()

"}}}

"{{{ Settings

"{{ General

set magic
set lazyredraw
set encoding=utf-8
set showmatch
set autoread
set updatetime=300
set mouse=a

"}}

"{{ Indentation

set ruler
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set autoindent
set smartindent
set nowrap
set bs=2

"}}

"{{ Search

set incsearch
set hlsearch
set smartcase

"}}

"{{ Syntax

filetype plugin indent on
syntax on
syntax sync minlines=100
syntax sync maxlines=240
set synmaxcol=800

" 4 spaces == 1 tab in php
autocmd BufNewFile,BufRead *.php call SetTabsSpacing()
function SetTabsSpacing()
    setlocal tabstop=4
    setlocal shiftwidth=4
endfunction

"}}

"{{ View

set conceallevel=3
set background=dark
colorscheme gruvbox
set cmdheight=2
set scrolloff=12
let &colorcolumn=80
if has('gui')
  :set guioptions-=m " remove menu bar
  :set guioptions-=T " remove toolbar
  :set guioptions-=r " remove right-hand scroll bar
  :set guioptions-=L " remove left-hand scroll bar
end
set shortmess+=A
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

"}}

set hidden
set nobackup
set nowritebackup
set completeopt-=preview

"{{ Sane splits

set splitbelow

"}}


"{{ Persistent Undo

"" Keep undo history across sessions by storing it in a file

if has('persistent_undo')
  let vim_dir = '$HOME/.vim'
  "let &runtimepath.=','.vim_dir
  let undo_dir = expand(vim_dir.'/undo')
  call system('mkdir ' . vim_dir)
  call system('mkdir ' . undo_dir)
  let &undodir = undo_dir
  set undofile
  set undodir=~/.vim/undo
  set undolevels=1000
  set undoreload=10000
endif

"}}


"{{ Clipboard

set clipboard=unnamed,unnamedplus

"}}

" clear highlighting on return in normal mode
nnoremap <silent> <CR> :noh<CR><CR>


"{{ No annoying bells

set noerrorbells
set novisualbell
set t_vb=
set tm=500

if has("gui_macvim")
  autocmd GUIEnter * set vb t_vb=
endif

"}}

"{{ Files

set nobackup
set nowb
set noswapfile

"}}

"}}}

"{{ Aliases

cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev X x

"}}



"{{{ Autoreload vim on changes made

augroup vimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

"}}}
