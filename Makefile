all: vundle clrs vrc xres plugins

vundle:
	@git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

clrs:
	@ln -s ~/dotfiles/colors ~/.vim/colors

vrc:
	@ln -s ~/dotfiles/vimrc ~/.vimrc

xres:
	@ln -s ~/dotfiles/Xresources ~/.Xresources

plugins:
	@vim +PluginInstall +qall
