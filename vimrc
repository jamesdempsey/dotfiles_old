" Map leader
let mapleader = ','

set guioptions=aAce

" For vim running in iTerm
colorscheme herald
set noantialias
set guifont=Dina:h16

" Map escape
imap kj <ESC>

" Easier split navigation
" Use Ctrl-[hjkl] to select active split
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>

" Save and quit
nmap <Leader>w :w<CR>
nmap <Leader>q :q!<CR>

" Map space bar and backspace
nnoremap <space> 10jzz
nnoremap <backspace> 10kzz

vmap <Leader>m <Leader>c<space>

" Turn off highlighting for current matches
nmap <Leader>h :nohls<CR>

" Tab for last buffer
nnoremap <Tab> :b#<CR>

" Sane Ignore For ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$',
  \ 'file': '\.exe$\|\.so$\|\.dat$'
  \ }

" Get rid of those annoying .swp files
set noswapfile

" Janus does some weird Sass syntax highlighting by default?
" Problem is ~/.vim/janus/vim/langs/scss/ftdetect/scss.vim runs
" au BufRead,BufNewFile *.scss set filetype=scss.css
" which sets css syntax highlighting for scss I think.
" Not what we want, so this undoes it:
au BufRead,BufNewFile *.scss set filetype=scss

" Ag, the new hotness
nnoremap <Leader>f :Ag!<Space>-i<Space>

" a 'change till' that's easier on the fingers
nnoremap df ct



" NEW SHIT
set nocompatible
set number
set ruler
syntax on
set encoding=utf-8

set hlsearch
set incsearch
set ignorecase
set smartcase

set fo+=o

set nowrap
set tabstop=2
set shiftwidth=2
set expandtab

nmap <leader>ew :e <C-R>=expand('%:h').'/'<cr>
nmap <leader>es :sp <C-R>=expand('%:h').'/'<cr>
nmap <leader>ev :vsp <C-R>=expand('%:h').'/'<cr>

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

filetype plugin indent on

set mouse=a

map <leader>n :NERDTreeToggle<CR>

let NERDTreeHijackNetrw = 0

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
let NERDTreeQuitOnOpen=1

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

let &shellpipe='&>'

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


set updatetime=1
au CursorHold,CursorHoldI * checktime
