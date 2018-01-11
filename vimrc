syntax on
set nocompatible
filetype off
set laststatus=2
set t_Co=256
set cursorline
colorscheme gruvbox
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set dir=~/.vimswap//,/var/tmp//,/tmp//,.
set clipboard=unnamed

set wildmenu
set nosmd

" disable stupid backup and swap files - they trigger too many events for file system watchers
set nobackup
set nowritebackup
set noswapfile

" splits
set splitright
set splitbelow

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'tpope/vim-surround'
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'kpron/vim-yaml-helper'
Plugin 'airblade/vim-gitgutter'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'junegunn/goyo.vim'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'fatih/vim-go'
Plugin 'tpope/vim-commentary'
Plugin 'majutsushi/tagbar'
Plugin 'andrewradev/linediff.vim'
Plugin 'rodjek/vim-puppet'
Plugin 'kpron/vim-dpaste'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'vimwiki/vimwiki'
Plugin 'skywind3000/quickmenu.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'vayw/toggle-bool'
Plugin 'junegunn/fzf' , { 'dir': '~/.fzf', 'do': './install --bin' }
Plugin 'junegunn/fzf.vim'
Plugin 'w0rp/ale'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'shougo/neopairs.vim'

call vundle#end()
filetype plugin indent on

" vim-dpaste params
let g:dpaste_url = "http://paste.ix/api/"

" Useful bubble text normal mapping for arrow keys.
nnoremap <UP> ddkP
nnoremap <DOWN> ddp
vnoremap <UP> xkP`[V`]
vnoremap <DOWN> xp`[V`]

map q: <Nop>
" Disable annoying ex mode (Q)
nnoremap Q <nop>

nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprev<CR>

" Auto complition hotkey
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>

map <F2> :NERDTreeToggle<CR>
nmap <F8> :TagbarOpenAutoClose<CR>

nnoremap <F3> :YamlGoToKey<Space>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

noremap <silent><F12> :call quickmenu#toggle(0)<cr>
call quickmenu#reset()
let g:quickmenu_options = "HL"

call g:quickmenu#append('MD5', 'Md5 `date +\%s`', 'Generate md5 hash')

let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'
let g:airline#extensions#tabline#enabled = 1

let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsEditSplit="vertical"

let g:ale_fixers = {
\   'javascript': ['eslint'],
\}

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" GO
" use goimports for formatting
let g:go_fmt_command = "goimports"

" turn highlighting on
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']

" Open go doc in vertical window, horizontal, or tab
au Filetype go nnoremap <leader>v :vsp <CR>:exe "GoDef" <CR>

function! s:UpdateBwLib( version )
	echom "Updating to" a:version
	execute "normal /wows-glossary-artefact\<CR>"
	execute "normal f[ci[".a:version
	execute "YamlGoToKey wows.bw.bw_lib_package"
	execute "normal f=2lc$".a:version
endfunction
command! -nargs=1 UpdateBwLib call s:UpdateBwLib("<args>")

function! s:UpdateApp(app, version)
    echom "Updating ".a:app." to ".a:version
    execute "YamlGoToKey ".a:app
    execute "normal /components_redefines\<CR>"
    execute "normal 2j2ddko"."branch: '".a:version."'"
    execute "normal o"."version: '".a:version."'"
endfunction
command! -nargs=* UpdateApp call s:UpdateApp(<f-args>)

function! s:FeBe( node )
    echom "Generate..."
    let feip = system('dig A +short '.a:node.".fe.core.pw|xargs echo -n")
    let beip = system('dig A +short '.a:node.".be.core.pw|xargs echo -n")
    let festr = "frontend_ip: ".feip
    let bestr = "backend_ip: ".beip
    let fqdn = "fqdn: ".a:node.".be.core.pw"
    execute "normal o".festr
    execute "normal o".bestr
    execute "normal o".fqdn
endfunction
command! -nargs=1 FeBe call s:FeBe("<args>")


function! s:Md5( key )
    echom "Generate..."
    let md5hash = system('echo '.a:key."|md5sum|cut -f1 -d' '")
    execute "normal o".md5hash
endfunction
command! -nargs=1 Md5 call s:Md5("<args>")


" Add the virtualenv's site-packages to vim path
if has('python')
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
endif
