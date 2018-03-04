# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

export EDITOR='emacs'

source $ZSH/oh-my-zsh.sh

alias ls='ls -Gah --color=always'
alias e='emacs'
alias gdiff=gistDiff
alias dclean=dockerClean

if which kubectl &> /dev/null && 
then
    source <(kubectl completion zsh)
    alias kc='kubectl'
fi

function gistDiff()
{
    git diff --no-color | gist -t diff
}

function dockerClean()
{
    docker rm -f $(docker ps -a -q)
    docker rmi -f $(docker images -q)
}
eval "$(thefuck --alias)"

export UPDATE_ZSH_DAYS=30

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

HIST_STAMPS="dd.mm.yyyy"

plugins=( git zsh-syntax-highlighting)
