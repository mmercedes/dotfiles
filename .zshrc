# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

export EDITOR='emacsclient'

source $ZSH/oh-my-zsh.sh

# mac vs linux exclusives
if [[ "$(uname -s)" == "Darwin" ]]; then
    export PATH=/usr/local/bin:$PATH
    export GOPATH=$HOME/development/go
    alias ls='ls -Gah'
else
    alias ls='ls -Gah --color=always'
fi

alias e='emacs'
alias todo='task'

if which kubectl &> /dev/null
then
    source <(kubectl completion zsh)
    alias kc='kubectl'
fi

if which git &> /dev/null
then
    git config --global alias.st 'status'
    git config --global alias.rpull 'pull --rebase --stat'
fi

function gdiff()
{
    git diff --no-color | gist -t diff
}

function dclean()
{
    docker rm -f $(docker ps -a -q)
    docker rmi -f $(docker images -q)
}

export UPDATE_ZSH_DAYS=30

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

HIST_STAMPS="dd.mm.yyyy"

plugins=( git zsh-syntax-highlighting)
