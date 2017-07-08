all: vundle fnt clrs vrc xres plugins ycm bashall

vundle:
	@git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

fnt:
	@git clone https://github.com/powerline/fonts.git /tmp/fonts && cd /tmp/fonts;bash install.sh
	@rm -rf /tmp/fonts
clrs:
	@ln -fs ~/dotfiles/colors ~/.vim/colors

vrc:
	@ln -fs ~/dotfiles/vimrc ~/.vimrc

xres:
	@ln -fs ~/dotfiles/Xresources ~/.Xresources
	@xrdb ~/.Xresources

plugins:
	@vim +PluginInstall +qall

ycm:
	@cd ~/.vim/bundle/YouCompleteMe && ./install.py

bashall: brc bext fcompl gpro

brc:
	@ln -sf ~/dotfiles/bashrc ~/.bashrc

bext:
	@ln -sf ~/dotfiles/bash ~/.bash

fcompl:
	@cd ~ ; git clone https://github.com/underself/fabric-completion

gpro:
	@cd ~ ; git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt

ciscosetup:
	@sudo mkdir /etc/rc.d
	@sudo bash vpnsetup.sh
