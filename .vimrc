if v:version < 705 &&  &shell =~# 'fish$'
  " vim before 7.5 for 'system' to work properly
  " https://github.com/fish-shell/fish-shell/issues/1494#issuecomment-46881273
  set shell=/bin/bash
endif

if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl --progress-bar -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    let plugInstalled = 1
endif
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'davidhalter/jedi-vim'
Plug 'flazz/vim-colorschemes'
Plug 'kchmck/vim-coffee-script'
Plug 'digitaltoad/vim-pug'
Plug 'wavded/vim-stylus'
Plug 'posva/vim-vue'
Plug 'cakebaker/scss-syntax.vim'
Plug 'sekel/vim-vue-syntastic'
Plug 'leafgarland/typescript-vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'brooth/far.vim'
call plug#end()
if exists("plugInstalled")
    PlugInstall
end

filetype plugin on
au! BufNewFile,BufRead *.sss set filetype=sass

colorscheme wombat256mod

silent "!mkdir ".$HOME.'/.vim/undo'
set undofile
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

if has("gui_running")
  set guioptions-=T "no toolbars
  set guioptions-=m "no menus
  "set gfn=Mono\ 12 "GUI font
endif

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

"fixing not working in urxvt bindings
map [5^ <C-PageUp>
map [6^ <C-PageDown>
map Oa <C-Up>
map Ob <C-Down>
map Od <C-Left>
map Oc <C-Right>

"handy movement between windows
map <C-j> <C-W>j
map <C-Down> <C-W>j
map <C-k> <C-W>k
map <C-Up> <C-W>k
map <C-h> <C-W>h
map <C-Left> <C-W>h
map <C-l> <C-W>l
map <C-Right> <C-W>l

"Navigate on long lines just as at break
map j gj
map <Down> gj
map k gk
map <Up> gk

if &term =~ "xterm\\|rxvt"
  let &t_SI = "\<Esc>]12;orange\x7"
  let &t_EI = "\<Esc>]12;gray\x7"
endif
if (exists('$TMUX'))
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]12;orange\x7\<Esc>\\"
  "use a grey cursor otherwise
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]12;gray\x7\<Esc>\\"
endif
if ($TERM_PROGRAM == 'iTerm.app')
    if (exists('$TMUX'))
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    else
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
endif
"upon hitting escape to change modes,
"send successive move-left and move-right
"commands to immediately redraw the cursor
"inoremap <special> <Esc> <Esc>hl

"mouse/scroll support in console vim
set mouse=a

set hlsearch "highlight searched word and patterns
set showmatch "show matched brackets
syntax on "highlight syntax, if found

"""programming specific:
set autoindent
set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab
set smarttab "seems that we don't need it
set smartindent "smart indent

set backspace=indent,eol,start
set modifiable

"really think this is a crap?
"set nobackup
"set noswapfile
set backupcopy=yes  "for proper webpack-dev-server changes monitoring

"autocmd FileType python autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")')) "delete spaces at end of lines on :write command on python

let python_highlight_all=1 "maximum highlight

set showbreak=^

set completeopt=longest,menuone,preview

set scrolloff=3 "keep X lines when moving vertical
set number "show row number
set cursorline "highlight line under cursor
"set showtabline=1 "show tabline only if there is more than 2 files
set statusline=%<%f%h%m%r%=0x%B\ %l,%c\ format=%{&fileformat}\ encoding=%{&fileencoding}\ %P
set laststatus=2 "always show status line

set wildmode=list:longest "use bash-like autocompletion style
set wildmenu

"set foldmethod=indent
"set foldnestmax=3 "maximum fold nest
""set foldlevel=0
set nofoldenable "no fold by default

"Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
"Remember info about open buffers on close
set viminfo^=%
set fileformats+=dos "do not auto-write new line at end of file

" Automatically set paste mode in Vim when pasting in insert mode
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif
  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"
  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" sudo tee on saving read-only file
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w !sudo tee %'):('W'))

" vim russian bindings
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

" Handy replace
vnoremap <C-r> "hy:%s%<C-r>h%%gc<left><left><left>

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_vue_checkers = ['eslint']
"Using local eslint if found
"let s:lcd = fnameescape(getcwd())
"silent! exec "lcd" expand('%:p:h')
if &shell =~# 'fish$'
  "set shell=sh
  let s:eslint_path = system('set NPM_BIN (npm bin); set PATH $NPM_BIN $PATH; which eslint')
else
  let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
endif
"exec "lcd" s:lcd
let g:syntastic_javascript_eslint_exec = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
let g:syntastic_vue_eslint_exec = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')

let g:syntastic_html_checkers=['']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_pug_checkers = ['pug_lint']

let g:jedi#show_call_signatures = "2"  "don't be fucking ridiculous

" Add the virtualenv's site-packages to vim path
" TODO: https://github.com/python-mode/python-mode/pull/609/files#diff-5e18f3af0b3035dd80efc88c25cf95eb
" activate_this removed for python3 manually created venv?
let env_activate = "".
\ "import os.path\n".
\ "import sys\n".
\ "if 'VIRTUAL_ENV' in os.environ or os.path.exists('./env/bin/python'):\n".
\ "    project_base_dir = os.environ.get('VIRTUAL_ENV', './env/')\n".
\ "    sys.path.insert(0, project_base_dir)\n".
\ "    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')\n".
\ "    exec(open(activate_this).read(), dict(__file__=activate_this))"

if has("python")
  python import vim; exec(vim.eval('env_activate'))
endif
if has("python3")
  python3 import vim; exec(vim.eval('env_activate'))
endif

" fix syntax highlight (for vue syntax for example)
" from http://vim.wikia.com/wiki/Fix_syntax_highlighting
"autocmd BufEnter * :syntax sync fromstart
" https://github.com/posva/vim-vue#my-syntax-highlighting-stops-working-randomly
autocmd FileType vue syntax sync fromstart
