all: vundle vimrc plugins

vundle:
	@git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vimrc:
	@ln -s ~/dotfiles/vimrc ~/.vimrc

plugins:
	@vim +PluginInstall +qall
