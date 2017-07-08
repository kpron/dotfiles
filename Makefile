all: vundle fnt clrs vrc xres plugins

vundle:
	@git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

fnt:
	@git clone https://github.com/powerline/fonts.git /tmp/fonts && cd /tmp/fonts;bash install.sh
	@rm -rf /tmp/fonts
clrs:
	@ln -s ~/dotfiles/colors ~/.vim/colors

vrc:
	@ln -s ~/dotfiles/vimrc ~/.vimrc

xres:
	@ln -s ~/dotfiles/Xresources ~/.Xresources

plugins:
	@vim +PluginInstall +qall
