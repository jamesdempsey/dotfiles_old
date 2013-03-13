set nocompatible
let mapleader = ','

"
" Vundle block
"

filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'rking/ag.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-rails'
Bundle 'kchmck/vim-coffee-script'
Bundle 'pangloss/vim-javascript'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-haml'
Bundle 'ap/vim-css-color'

filetype plugin indent on

"
" The basics
"

set number
set ruler
syntax enable
set encoding=utf-8
set noswapfile
set showmatch
set history=256
set clipboard+=unnamedplus
set fo+=o
set fo-=r
set backspace=indent,eol,start
set mouse-=a
set mousehide
set splitbelow
set splitright
colorscheme herald

"
" Statusline
"

hi User1 ctermbg=0 ctermfg=84 cterm=none
set statusline=%<
set statusline+=\ %n:%f
set statusline+=\ %m%r%y
set statusline+=%=%l/%L
set statusline+=\ %1*%c%*
set statusline+=\ (%P)
set laststatus=2

"
" Whitespace
"

set nowrap
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2
set list

"
" List chars
"

set listchars=""
set listchars=tab:\ \
set listchars+=trail:.
set listchars+=extends:>
set listchars+=precedes:<

"
" Searching
"

set hlsearch
set incsearch
set ignorecase
set smartcase

"
" Mappings
"

" Quick escape
imap kj <ESC>

" Save and quit
nmap <Leader>w :w<CR>
nmap <Leader>q :q!<CR>

" Easier split navigation
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>

" Turn off highlighting for current matches
nmap <Leader>h :nohls<CR>

" Faraway files
nmap <leader>ew :e <C-R>=expand('%:h').'/'<cr>
nmap <leader>es :sp <C-R>=expand('%:h').'/'<cr>
nmap <leader>ev :vsp <C-R>=expand('%:h').'/'<cr>

" Quick NERDCommentToggle
vmap <Leader>m <Leader>c<space>
map <Leader>m <Leader>c<space>

" Tab for last buffer
nnoremap <Tab> :b#<CR>

" Jump around
nnoremap <space> 10jzz
nnoremap <backspace> 10kzz

" Quick 'change till'
nnoremap df ct

" Ag, the new hotness
nnoremap <Leader>f :Ag!<Space>-i<Space>

" Quick NERDTreeToggle
nnoremap <leader>n :NERDTreeToggle<CR>

"
" Other settings
"
au BufRead,BufNewFile {*.md,*.mkd,*.markdown} setf markdown

au CursorHold,CursorHoldI * checktime " Check if file's been modified after CursorHold
set updatetime=1                      " Check when CursorHold > 1 millisecond

let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Start Insert as vertical line
let &t_EI = "\<Esc>]50;CursorShape=0\x7" " End Insert as block

let &shellpipe='&>' " Don't pipe ag/ack/grep output to terminal (still flashes)

" Sane ignore for CtrlP
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$',
  \ 'file': '\.exe$\|\.so$\|\.dat$'
  \ }

" Way too many NERDTree settings
let NERDTreeHijackNetrw = 0
let NERDTreeQuitOnOpen=1

augroup AuNERDTreeCmd
autocmd AuNERDTreeCmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
autocmd AuNERDTreeCmd FocusGained * call s:UpdateNERDTree()

" If the parameter is a directory, cd into it
function s:CdIfDirectory(directory)
  let explicitDirectory = isdirectory(a:directory)
  let directory = explicitDirectory || empty(a:directory)

  if explicitDirectory
    exe "cd " . fnameescape(a:directory)
  endif

  " Allows reading from stdin
  " ex: git diff | mvim -R -
  if strlen(a:directory) == 0
    return
  endif

  if directory
    NERDTree
    wincmd p
    bd
  endif

  if explicitDirectory
    wincmd p
  endif
endfunction

" NERDTree utility function
function s:UpdateNERDTree(...)
  let stay = 0

  if(exists("a:1"))
    let stay = a:1
  end

  if exists("t:NERDTreeBufName")
    let nr = bufwinnr(t:NERDTreeBufName)
    if nr != -1
      exe nr . "wincmd w"
      exe substitute(mapcheck("R"), "<CR>", "", "")
      if !stay
        wincmd p
      end
    endif
  endif
endfunction

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
