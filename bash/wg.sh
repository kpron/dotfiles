PROJECTS_DIR="WGProjects"
if [ -d "~/$PROJECTS_DIR" ]; then
    alias ls="ls --color=auto"
    alias wd="cd ~/$PROJECTS_DIR/web_deploy"
    alias mf="cd ~/$PROJECTS_DIR/mini_fabrics; vim"
    alias st="cd ~/$PROJECTS_DIR/staging_configs; vim"
    alias prod="cd ~/$PROJECTS_DIR/configs; vim"
    alias vrc="vim ~/.vimrc"
    alias spbprod="cd ~/$PROJECTS_DIR/spb_prod_configs; vim"
    alias puppetstagings="cd ~/$PROJECTS_DIR/puppet-stagings; vim"
    source ~/$PROJECTS_DIR/venv/bin/activate

    export PATH=$PATH:/opt/cisco/anyconnect/bin
    alias wgvpn="sudo vpnagentd && vpnui &"
fi
