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

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'tpope/vim-surround'
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'lmeijvogel/vim-yaml-helper'
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

call vundle#end()
filetype plugin indent on

" Useful bubble text normal mapping for arrow keys.                                                                                        
nnoremap <UP> ddkP 
nnoremap <DOWN> ddp
vnoremap <UP> xkP`[V`]
vnoremap <DOWN> xp`[V`]


nmap <Tab> :bnext<CR>

map <F2> :NERDTreeToggle<CR>
nmap <F8> :TagbarOpenAutoClose<CR>

nnoremap <F3> :YamlGoToKey<Space>
let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'
let g:airline#extensions#tabline#enabled = 1

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
