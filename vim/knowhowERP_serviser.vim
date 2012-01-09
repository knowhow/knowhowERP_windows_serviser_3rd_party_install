set nocompatible

" http://nvie.com/posts/how-i-boosted-my-vim/


set hidden
set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
" set autoindent    " always set autoindenting on
" set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
" set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

syntax enable
" set background=dark
" set background=light
" colorscheme solarized

" status line
set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v]\ [%p%%]\ [LEN=%L]

" now set it up to change the status line based on mode
if version >= 700
  "au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
  au InsertEnter * hi StatusLine term=reverse ctermfg=2 ctermbg=2 gui=underline guisp=White
  au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=0 gui=bold,reverse

endif

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

set nobackup
set noswapfile

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

let mapleader = ","

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" sa ,W skloni sve suvisne white space-ove
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" sa ,<strelica dole> idi na kraj tekuceg buffer-a
" nnoremap <leader><down> 10000000gg

" http://newbiedoc.sourceforge.net/tutorials/vim/example-vim.html.en
map! ,h1 <h1></h1><ESC>2ba
map tv :echo 'Tekuće vrijeme je ' . strftime('%c')<CR>

set wrap
"map <F1> :NERDTree<CR>:wincmd p<CR>
noremap nt :NERDTreeToggle<CR>
map <F3> <C-]>
map <F2> <C-O>

au! BufWritePost .vimrc source %

filetype plugin indent on     " required! 

" Find file in current directory and edit it.
function! Find(name)
  let l:list=system("find . -name '".a:name."' | perl -ne 'print \"$.\\t$_\"'")
  let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))
  if l:num < 1
    echo "'".a:name."' not found"
    return
  endif
  if l:num != 1
    echo l:list
    let l:input=input("Which ? (CR=nothing)\n")
    if strlen(l:input)==0
      return
    endif
    if strlen(substitute(l:input, "[0-9]", "", "g"))>0
      echo "Not a number"
      return
    endif
    if l:input<1 || l:input>l:num
      echo "Out of range"
      return
    endif
    let l:line=matchstr("\n".l:list, "\n".l:input."\t[^\n]*")
  else
    let l:line=l:list
  endif
  let l:line=substitute(l:line, "^[^\t]*\t./", "", "")
  execute ":e ".l:line
endfunction
command! -nargs=1 Find :call Find("<args>")


" dupliciraj rijec iznad
"nmap dup <ESC>kyWjP<SPACE>
nmap dup <ESC>kvWyjP

" select all
imap <c-a> <ESC>ggVG<CR>


" http://vim.wikia.com/wiki/Enhanced_Ctrl-A
function! AddSubtract(operation, direction)
  if &nrformats =~ 'alpha'
    let pattern = '[[:alpha:][:digit:]]'
  else
    let pattern = '[[:digit:]]'
  endif
  if 'b' == a:direction
    call search(pattern, 'bcw')
  else
    call search(pattern, 'cw')
  endif
  if 'a' == a:operation
    execute 'normal! ' . v:count1 . "\<C-a>"
    silent! call
        \ repeat#set(":\<C-u>call AddSubtract('a', '" .a:direction. "')\<CR>")
  else
    execute 'normal! ' . v:count1 . "\<C-x>"
    silent! call
        \ repeat#set(":\<C-u>call AddSubtract('s', '" .a:direction. "')\<CR>")
  endif
endfunction
nnoremap <silent>         <C-a> :<C-u>call AddSubtract('a', 'f')<CR>
nnoremap <silent> <Leader><C-a> :<C-u>call AddSubtract('a', 'b')<CR>
nnoremap <silent>         <C-x> :<C-u>call AddSubtract('s', 'f')<CR>
nnoremap <silent> <Leader><C-x> :<C-u>call AddSubtract('s', 'b')<CR>

function! ToogleToolBar()

if &guioptions =~# 'T' 
	set guioptions-=T 
"	set guioptions-=m
	echo "no toolbar/menu"
else 
	set guioptions+=T
"	set guioptions+=m
    echo "toolbar/menu are here"
endif

endfunction

"map <silent> <c-t> :call ToogleToolBar()<CR>

nmap <CR> <C-]>
nmap <BS> <C-T>

" window zoom - zatvori sve ostale prozore 
nmap zoom <C-W>o

" otvori vimrc i pozicioniraj se na kraj
nmap vimrc :ed ~/.vimrc<CR>GGo

nmap tb :TagbarToggle<CR>

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

set tabstop=4
set shiftwidth=4
set expandtab

nmap <c-V> :exe "vimgrep /o[nd][ ]\\+" . expand("<cword>") . "/j **/*.prg" <Bar> cw<CR> 
nmap <c-G> :exe "vimgrep /" . expand("<cword>") . "/j **/*.prg" <Bar> cw<CR>

function! FindFunc(name)
    echo ":cl - lista pronadjenih stavki u prg-ovima, :cn - sljedeca stavka, :cc1 - prva stavka, :cc2 - druga stavka" 
    execute  ":vimgrep /o[nd][ ]\\+" .a:name. "/j **/*.prg" 
    execute  ":cl" 
endfunc
command! -nargs=1 FindFunc :call FindFunc("<args>")

function! FindIdent(name)
    echo ":cl - lista pronadjenih stavki u prg-ovima, :cn - sljedeca stavka, :cc1 - prva stavka, :cc2 - druga stavka" 
    execute  ":vimgrep /" .a:name. "/j **/*.prg" 
    execute  ":cl" 
endfunc
command! -nargs=1 FindIdent :call FindIdent("<args>")


set fileencoding=utf-8
set encoding=utf-8
