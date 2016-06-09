"####################
"# DISPLAY SETTINGS #
"####################
"set ambiwidth=double
set number
"set list
set showmatch
set title
set showmode
set cursorline
set ruler
set showcmd
set showtabline=2
set cmdheight=2
set laststatus=2
set wrap
syntax on

"###################
"# INDENT SETTINGS #
"###################
set cindent
set autoindent
set expandtab "Converts tab -> space
set smartindent
set smarttab
set shiftwidth=4 "# of space inserted automatically
set tabstop=4 sts=0
filetype plugin indent off

"###################
"# SEARCH SETTINGS #
"###################
set hlsearch
set incsearch
set ignorecase
set smartcase
"set wrapscanset

"############################
"# SWP/BACKUP/UNDO SETTINGS #
"############################
set backup
set swapfile
set backupdir=$HOME/.vim/.backup//
set directory=$HOME/.vim/.swp//
set undodir=$HOME/.vim/.undo//
set writebackup

"##################
"# OTHER SETTINGS #
"##################
set nocompatible " no compatible with vi
set backspace=2
set clipboard=unnamed
set wildmenu
set wildmode=list:full
set wildignore=*.o,*.obj,*.pyc,*.so,*.dll
set foldenable
set foldmethod=indent
set foldopen=all
set foldlevel=0
set foldnestmax=2
set foldcolumn=2

let g:python_highlight_all = 1

command Vimrc :tabnew ~/.vimrc

"####################
"# AUTOCMD SETTINGS #
"####################
augroup General
 autocmd!
 autocmd BufWinLeave * silent mkview
 autocmd BufWinEnter * silent loadview
augroup END

augroup C_Cpp
 function! s:setC_Cpp()
 nnoremap  .gcc :!gcc %
 set cindent
 endfunction
 autocmd BufRead *.c,*.cpp call s:setC_Cpp()
augroup END

"######################
"# NEOBUNDLE SETTINGS #
"######################
if has('vim_starting')
  if &compatible
    set nocompatible
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'grep.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle "Shougo/neosnippet"
NeoBundle "Shougo/neosnippet-snippets"
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle "Shougo/unite-outline"
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'MaxMEllon/vim-tmng'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'Shougo/vimshell'
NeoBundle 'glidenote/memolist.vim'
NeoBundle 'fuenor/qfixgrep'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'kana/vim-operator-user'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-operator-replace'
NeoBundle 'rhysd/vim-operator-surround'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'andviro/flake8-vim'
NeoBundle 'hynek/vim-python-pep8-indent'
NeoBundle 'bps/vim-textobj-python'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

"#############
"# unite.vim #
"#############
" startup on input mode
" let g:unite_enable_start_insert=1
" buffer list
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" file list
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" register list
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" file list used recent
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" usually
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" all
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" open w/split horizontal
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" open w/split vertical
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" Ends by ESC twice
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

let g:unite_split_rule = 'botright'
noremap ,u <ESC>:Unite -vertical -no-quit outline<Return>

"###################
"# neocomplete.vim #
"###################
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()

" Recommended key-mappings.
"  <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
"   " <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^.\t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:]*\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:]*\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl ='\h\w*->\h\w*\|\h\w*::'
"################
"# memolist.vim #
"################
map <Leader>mn  :MemoNew<CR>
map <Leader>ml  :MemoList<CR>
map <Leader>mg  :MemoGrep<CR>
let g:memolist_memo_suffix = "txt"
let g:memolist_memo_date = "%Y-%m-%d %H:%M"
let g:memolist_memo_date = "epoch"
let g:memolist_memo_date = "%D %T"
let g:memolist_prompt_tags = 1
let g:memolist_prompt_categories = 1
let g:memolist_vimfiler = 1
let g:memolist_template_dir_path = "~/.vim/templates/memolist"
let g:memolist_qfixgrep = 1


"#######################
"# ftplugin/python.vim #
"#######################

if exists('b:did_ftplugin_python')
    finish
endif
let b:did_ftplugin_python = 1

setlocal smarttab
setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal foldmethod=indent
setlocal commentstring=#%s

" - af: a function
" - if: inner function
" - ac: a class
" - ic: inner class

" this plugin has aditional key-bind
"  -  '[pf', ']pf': move to next/previous function
"  -  '[pc', ']pc': move to next/previous class
xmap <buffer> af <Plug>(textobj-python-function-a)
omap <buffer> af <Plug>(textobj-python-function-a)
xmap <buffer> if <Plug>(textobj-python-function-i)
omap <buffer> if <Plug>(textobj-python-function-i)
xmap <buffer> ac <Plug>(textobj-python-class-a)
omap <buffer> ac <Plug>(textobj-python-class-a)
xmap <buffer> ic <Plug>(textobj-python-class-i)
omap <buffer> ic <Plug>(textobj-python-class-i)

setlocal omnifunc=jedi#completions

if version < 600
  syntax clear
elseif exists('b:current_after_syntax')
  finish
endif

" We need nocompatible mode in order to continue lines with backslashes.
" Original setting will be restored.
let s:cpo_save = &cpo
set cpo&vim

syn match pythonOperator "\(+\|=\|-\|\^\|\*\)"
syn match pythonDelimiter "\(,\|\.\|:\)"
syn keyword pythonSpecialWord self

hi link pythonSpecialWord    Special
hi link pythonDelimiter      Special

let b:current_after_syntax = 'python'

let &cpo = s:cpo_save
unlet s:cpo_save
