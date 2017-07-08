all: vundle clrs vrc plugins

vundle:
	@git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

clrs:
	@ln -s ~/dotfiles/colors ~/.vim/colors

vrc:
	@ln -s ~/dotfiles/vimrc ~/.vimrc

plugins:
	@vim +PluginInstall +qall
