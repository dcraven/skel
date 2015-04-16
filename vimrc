"===============================================================================
"==========  CUSTOMIZATION (vimrc)  ============================================
" Last Modified: April 16, 2015
"===============================================================================
set nocompatible
filetype off

" ======================= Begin Vundle Configuration =====================
" Clone Vundle 
" $ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle

set runtimepath+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'dcraven/vim-deserted.git'
Bundle 'vim-scripts/xptemplate.git'
Bundle 'gregsexton/gitv.git'
Bundle 'elzr/vim-json.git'
Bundle 'jgdavey/vim-blockle.git'
Bundle 'kana/vim-textobj-user.git'
Bundle 'kien/ctrlp.vim.git'
Bundle 'pangloss/vim-javascript.git'
Bundle 'scrooloose/nerdtree.git'
Bundle 'sickill/vim-pasta.git'
Bundle 'timcharper/textile.vim.git'
Bundle 'tomtom/tcomment_vim.git'
Bundle 'tpope/vim-cucumber.git'
Bundle 'tpope/vim-endwise.git'
Bundle 'tpope/vim-fugitive.git'
Bundle 'tpope/vim-git.git'
Bundle 'tpope/vim-haml.git'
Bundle 'tpope/vim-markdown.git'
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-repeat.git'
Bundle 'tpope/vim-surround.git'
Bundle 'tpope/vim-vividchalk.git'
Bundle 'tmhedberg/matchit.git'
Bundle 'tsaleh/vim-shoulda.git'
Bundle 'tsaleh/vim-tmux.git'
Bundle 'vim-ruby/vim-ruby.git'
Bundle 'vim-scripts/Gist.vim.git'
Bundle 'vim-scripts/IndexedSearch.git'
Bundle 'vim-scripts/jQuery.git'
Bundle 'Lokaltog/vim-powerline.git'
Bundle 'slim-template/vim-slim.git'
Bundle 'tpope/vim-rbenv.git'
Bundle 'bling/vim-airline'

" ======================= End Vundle Configuration =====================

syntax on
filetype plugin indent on

"}}}
"===============================================================================
" Custom Variable Settings Start Here {{{
"===============================================================================
if version >= 700
    " preserve window view (position) when switching buffers
    au BufLeave * let b:winview = winsaveview()
    au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
endif
" }}}

" Version 7.3 features
if version >= 703
    set undofile
    let undos = expand('~/.local/share/vim/undo')
    if isdirectory(undos) == 0
        call mkdir(undos, "p")
    endif
    let &undodir=undos
endif
"
"If this is Terminal.app, do cursor hack for visible cursor
"This hack does not behave well with other terminals (particularly xterm)
function MacOSX()
  hi CursorLine term=none cterm=none "Invisible CursorLine
  set cursorline "cursorline required to continuously update cursor position
  hi Cursor cterm=reverse "I like a reversed cursor, edit this to your liking
  match Cursor /\%#/ "This line does all the work
endfunction

if $TERM_PROGRAM == "Apple_Terminal" " Terminal.app, xterm and urxvt pass this test
 if $WINDOWID == ""                  " xterm and urxvt don't pass this test
  "It is unlikely that anything except Terminal.app will get here
  call MacOSX()
 endif
endif

if $SSH_TTY != ""            " If the user is connected through ssh
 if $TERM == "xterm-color" || $ORIGTERM = "xterm-color"
  "Something other than Terminal.app might well get here
  call MacOSX()
 endif
endif

set backup
let backups = expand('~/.local/share/vim/backup')
if isdirectory(backups) == 0
    call mkdir(backups, "p")
endif
let &backupdir=backups

" VCSCommand Stuff
let g:VCSCommandDeleteOnHide = 1

" NERD Commenter Stuff
let g:NERDShutUp = 1
" Insert comment inline
imap <C-C> <plug>NERDCommenterInInsert

" Auto-clean fugitive buffers ffs
autocmd BufReadPost fugitive://* set bufhidden=delete
" Quick Ggrep word under cursor
nmap <Leader>gg :Git <C-R><C-W><CR>
vmap <Leader>vg ""y:Ggrep '<C-R>"'<CR>

" Open QuickFix window when using grep
autocmd QuickFixCmdPost *grep* cwindow

" Gitv mappings
nmap <leader>gv :Gitv --all<cr>
nmap <leader>gV :Gitv! --all<cr>
vmap <leader>gV :Gitv! --all<cr>

" FSwitch settings
com! A       :call FSwitch('%', '')

"===============================================================================
" Various Custom Settings Start Here
"===============================================================================
let NERDShutUp=1
let NERDTreeShowBookmarks=1

colorscheme deserted

if has ("gui_running")
    set cursorline
    set guicursor=a:blinkon0
    set guifont=Consolas\ 11
    set guioptions=agirLtc
endif

" Keep bzr commit logs <=70 chars per line
if expand("%:t") =~ "^bzr_log*"
    set textwidth=70
    set filetype=none
    syn match commitComment "^#.*"
    hi link commitComment Comment
endif

set cscopequickfix=s-,c-,d-,i-,t-,e-
set cscopetag


"CScope Stuff
if has("cscope")
   set csto=1
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add cscope.out
      " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

"Taglist Stuff
"if filereadable('/usr/bin/ctags')
    "let Tlist_Ctags_Cmd = '/usr/bin/ctags'
    "let Tlist_Process_File_Always = 1
    "let Tlist_File_Fold_Auto_Close = 1
    "let Tlist_Auto_Update = 1
    "set title titlestring=%<%f\ \ \ \ \ \ \ \ \ %([\ %{Tlist_Get_Tag_Prototype_By_Line()}\ ]%)
    "nmap <F11> :TlistToggle<CR>
    "nmap <F10> :TlistUpdate<CR>
"endif

nmap <F9> :NERDTreeToggle<CR>

" Make a lovely statusline
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=%{fugitive#statusline()}
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
set statusline+=%b,0x%-8B\                   " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset


set notitle
set noautochdir
set iskeyword ="a-z,A-Z,48-57,_,.,-,>,^px"
set complete=.,w,b,t,]
set completeopt=menu,preview,longest
set clipboard=unnamed
set t_Co=256
set hidden
set nostartofline
set fo=qwantc1
set mousemodel=popup_setpos
set nomousehide
set mouse=a
set smarttab
set noignorecase
set smartcase
set sessionoptions+=resize
set softtabstop=4
set expandtab
set backspace=indent,eol,start
set grepprg=grep\ -nH\ $*
set incsearch
set autoread
set autowrite
set nohlsearch
set autoindent
set laststatus=2
set scrolloff=3
set history=500
set ruler   
set showcmd
set showmatch
set magic
set report=0
set shiftwidth=4
set tabstop=8
set wildmenu
set wildmode=list:longest
set novisualbell
set nowrap
set linebreak
set browsedir=current 
set foldlevelstart=999
"set foldmethod=syntax
set foldnestmax=2
set cmdheight=2
set wildmenu
set wildignore+=*.bak,*.pyc,*.pyo,*.o,*.e,*~,*.png,*.jpg,*.swp,*.swo,*.zip
set printoptions=left:8pc,right:3pc

let javaScript_fold=1
"===============================================================================
" Custom Abbreviations Start Here"{{{
"===============================================================================
" Replace :b with :Bs for running BufSel (local function)
cabbr b Bs

" Stop mistyping make!
cabbr mkae make
" }}}
"===============================================================================
" Custom Key Mapping Start Here
"===============================================================================

" Open current document in Marked.app
nnoremap <leader>m :silent !open -a Marked.app '%:p'<cr>:redraw!<cr>

" Insert an empty line without entering insert mode.
nnoremap ]<Space> m`o<Space><C-U><Esc>``
nnoremap [<Space> m`O<Space><C-U><Esc>``

" <Leader>bd kills buffer, but preserves layout (local function)
map <silent> <Leader>db :call Kwbd(1)<CR>

" <Leader>bo kills all buffers but the active one (local function)
map <silent> <Leader>bo :call BufOnly()<CR>

" Make spacebar open and close folds.
nnoremap <Space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR> 

" Backspace deletes folds
nnoremap <BS> zd

" And Space creates folds in Visual.
vnoremap <Space> zf

" Make screen scrolling doable in Insert mode.
inoremap <C-E> <C-X><C-E>
inoremap <C-Y> <C-X><C-Y>

" Make '' work like `` instead.
map ' `

" Toggle hlsearch.. It is handy from time to time.
map <silent> <F12> :set hlsearch!<CR>

" Let's stay in Visual mode after an indent.
vnoremap > >gv
vnoremap < <gv

" Search for visually blocked phrase.
vmap / y/<C-R>"<CR>

" Map <C-K> to swap between MRU buffers, <C-H> and <C-L> cycle.
nmap <C-K> <C-^>
nmap <C-H> :bp<CR>
nmap <C-L> :bn<CR>

" Change to current file's dir
nmap <Leader>cd :lcd <C-R>=expand('%:p:h')<CR><CR>

" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p :call setreg('"', getreg('0')) <CR>


" Source the ~/.vimrc file.
nmap <F3> :so ~/.vimrc<CR>

" Source the current file.
nmap <F4> :so %<CR>

" Map F5 to toggle spelling (local function)
map <silent> <f5> :call Speller()<cr>

" XPSnippets options
let g:xptemplate_bundle = 'javascript_jquery'
let g:xptemplate_brace_complete = '([{'
let g:xptemplate_vars = "SParg="

" Bring up the CtrlP window
nmap <silent> ,t :CtrlP<CR>

" Settings for vim-indent-guides plugin
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_indent_levels = 5

"===============================================================================
" Custom Functions Start Here"{{{
"-------------------------------------------------------------------------------
" GrepCurrentBuffer: Grep the current buffer for the word under the cursor
command! -nargs=1 GrepCurrentBuffer call GrepCurrentBuffer('<args>')
fun! GrepCurrentBuffer(q)
	let save_cursor = getpos(".")
  let save_errorformat = &errorformat
  try
    set errorformat=%f:%l:%m
    cexpr []
    exe 'g/'.escape(a:q, '/').'/caddexpr expand("%") . ":" . line(".") .  ":" . getline(".")'
    cw
  finally
    call setpos('.', save_cursor)
    let &errorformat = save_errorformat
  endtry
endfunction
noremap <leader>. :GrepCurrentBuffer <C-r><C-w><cr>

" Speller: Turn on/off spellchecker."{{{
function! Speller()
        if (&spell)
                setlocal nospell
                echo "Speller OFF"
        else
                setlocal spell spelllang=en_ca
                echo "Speller ON"
        endif
endfunction
command! Spell call Speller()
" End Speller }}}

" TabMessage: Put output of ex commands in a new tab."{{{
function! TabMessage(cmd)
    redir => message
    silent execute a:cmd
    redir END
    tabnew
    silent put=message          
    set nomodified
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)
" End TabMessage }}}

" Highlight trailing whitespace in red
"highlight ExtraWhitespace ctermbg=red guibg=red
"match ExtraWhitespace /\s\+$/
"autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
"autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"autocmd InsertLeave * match ExtraWhitespace /\s\+$/
"autocmd BufWinLeave * call clearmatches()
" End highlight trailing whitespace

" JumpCursorOnEdit(): Make cursor jump to last known line."{{{
augroup JumpCursorOnEdit
  au!
  autocmd BufReadPost *
    \ if expand("<afile>:p:h") !=? $TEMP |
    \   if line("'\"") > 1 && line("'\"") <= line("$") |
    \     let JumpCursorOnEdit_foo = line("'\"") |
    \     let b:doopenfold = 1 |
    \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
    \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
    \        let b:doopenfold = 2 |
    \     endif |
    \     exe JumpCursorOnEdit_foo |        
    \   endif |
    \ endif
  " Need to postpone using "zv" until after reading the modelines.
  autocmd BufWinEnter *
    \ if exists("b:doopenfold") |
    \   exe "normal zv" |
    \   if(b:doopenfold > 1) |
    \       exe  "+".1 |
    \   endif |
    \   unlet b:doopenfold |
    \ endif
augroup END
"}}} End JumpCursorOnEdit()

" BufSel: Select from buffers matching a certain pattern (case insensitive)"{{{
"         Case sensitivity can be altered by setting g:BufSel_Case_Sensitive
function! BufSel(pattern)
    let buflist = []
    let bufcount = bufnr("$")
    let currbufnr = 1

    while currbufnr <= bufcount
        if(buflisted(currbufnr))
            let currbufname = bufname(currbufnr)
            if (exists("g:BufSel_Case_Sensitive") == 0 || g:BufSel_Case_Sensitive == 0)
                let curmatch = tolower(currbufname)
                let patmatch = tolower(a:pattern)
            else
                let curmatch = currbufname
                let patmatch = a:pattern
            endif
            if(match(curmatch, patmatch) > -1)
                call add(buflist, currbufnr)
            endif
        endif
        let currbufnr = currbufnr + 1
    endwhile
    if(len(buflist) > 1)
        for bufnum in buflist
            echo bufnum . ":      ". bufname(bufnum)
        endfor
        let desiredbufnr = input("Enter buffer number: ")
        if(strlen(desiredbufnr) != 0)
            exe ":bu ". desiredbufnr
        endif
    elseif (len(buflist) == 1)
        exe ":bu " . get(buflist,0)
    else
        echo "No matching buffers"
    endif
endfunction 
command! -nargs=1 -complete=buffer Bs :call BufSel("<args>")
"}}}

" Kwbd: Kill the current buffer, but don't change the layout."{{{
function! Kwbd(kwbdStage)
    if(a:kwbdStage == 1)
        let g:kwbdBufNum = bufnr("%")
        let g:kwbdWinNum = winnr()
        windo call Kwbd(2)
        execute "bdelete " . g:kwbdBufNum
        execute "normal " . g:kwbdWinNum . ""
    else
        if(bufnr("%") == g:kwbdBufNum)
            let prevbufvar = bufnr("#")
            if(prevbufvar > 0 && buflisted(prevbufvar) && prevbufvar != g:kwbdBufNum)
                b #
            else
                bn
            endif
        endif
    endif
endfunction
" End Kwbd }}}

" BufOnly: Delete all listed buffers except the current one. "{{{
function! BufOnly()
    let curBuffer = bufnr("%")
    let ListedBuffers = []
    let i = 1
    while (i <= bufnr("$"))
        if (bufexists(i) && buflisted(i))
            call add(ListedBuffers, i)
        endif
        let i+= 1
    endwhile
    for item in ListedBuffers
        if (item != curBuffer)
            execute "silent bdelete " . item
        endif
    endfor
endfunction
" }}}

" Find: find a file in the tree below who's name matches exerpts given. "{{{
function! Find(name)
    let l:_name = substitute(a:name, "\\s", "*", "g")
    let l:list = split(system("find . -iname '*" . l:_name . "*'"), '\n')

    let index = 1
    let matches = []
    let excludes = ["\.svn"]
    for item in l:list
        for pat in excludes
            if match(item, pat) != -1
                call remove(l:list, item)
                continue
            else
                call add(matches, index . "\t" . item)
                let index += 1
            endif
        endfor
    endfor

    let l:num = len(matches)
    if l:num < 1
        echo "'".a:name."' not found"
        return
    endif

  if l:num != 1
      for item in matches
          echo item
      endfor
      let l:input=input("Which ? (<enter>=nothing): ")

      if strlen(l:input)==0
          return
      endif

      if strlen(substitute(l:input, "[0-9]", "", "g"))>0
          echo "\nNot a number"
          return
      endif

      if l:input<1 || l:input>l:num
          echo "\nOut of range"
          return
      endif

      let l:line = matches[l:input - 1]
  else
      let l:line=matches[0]
  endif

  let l:line = substitute(l:line, ".*\t", "", "")
  execute ":e ".l:line
endfunction
command! -nargs=1 Find :call Find("<args>")
"}}}

function! Hex2Dec()
   let hexstr = expand("<cword>")
   let decstr = hexstr + 0
   echo "Decimal: " . decstr
endfunction
map <Leader>hd :call Hex2Dec()<CR>

"}}} End Custom Function
"
autocmd BufWritePre,FileWritePre *  ks|call LastMod()|'s
fun! LastMod()
  if line("$") > 20
    let l = 20
  else
    let l = line("$")
  endif
  exe "1," . l . "g/Last Modified: /s/Last Modified: .*/Last Modified: " . strftime("%B %d, %Y")
endfun

map , <Leader>

" vim: set fdm=marker:
