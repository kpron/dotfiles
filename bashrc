#
# ~/.bashrc
#
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export BROWSER="chromium"
export GOPATH=~/go
export PATH=$PATH:~/go/bin
export PATH=$PATH:/usr/local/bin
export EDITOR="vim"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
# Disable ttystop
stty stop ''

PS1='[\u@\h \W]\$ '
GIT_PROMPT_ONLY_IN_REPO=1
GIT_PROMPT_THEME=Crunch
source ~/.bash-git-prompt/gitprompt.sh

source ~/fabric-completion/fabric-completion.bash

if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
  ssh-add
  ssh-add ~/.ssh/kpron
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

source ~/.bash/wg.sh
