# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#export ZSH_THEME="robbyrussell"
export ZSH_THEME="bira"

export EDITOR='emacsclient -nw'

export DISABLE_UNTRACKED_FILES_DIRTY='true'

source $ZSH/oh-my-zsh.sh

# mac vs linux exclusives
if [[ "$(uname -s)" == "Darwin" ]]; then
    export PATH=/usr/local/bin:$PATH
    export GOPATH=$HOME/development/go
    alias emacs='/usr/local/bin/emacs'
    alias ls='ls -Gah'
    alias stat='stat -x'
else
    alias ls='ls -Gah --color=always'
    export GREP_OPTIONS='--exclude=*.pyc --exclude-dir=.git'
fi

alias e='emacsclient -nw'
alias todo='task'

if which kubectl &> /dev/null
then
    source <(kubectl completion zsh)
    alias kc='kubectl'
fi

if which git &> /dev/null
then
    git config --global core.excludesfile ~/.gitignore
    git config --global alias.c 'checkout'
    git config --global alias.cp 'cherry-pick'
    git config --global alias.d 'diff'
    git config --global alias.ds 'diff --staged'
    git config --global alias.rpull 'pull --rebase --stat'
    git config --global alias.prull 'pull --rebase --stat'
    git config --global alias.s 'status'
    git config --global alias.st 'status'
    git config --global alias.cm 'checkout master'
fi

if which jenv &> /dev/null
then
    export PATH="$HOME/.jenv/bin:$PATH"
    eval "$(jenv init -)"
    export JAVA_HOME="$HOME/.jenv/versions/$(jenv version-name)"
fi

if which pyenv &> /dev/null
then
    eval "$(pyenv init -)"
    export PATH="/Users/mmercedes/.pyenv/shims:$PATH"
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

function gr()
{
    grep -r "$@"
}

export UPDATE_ZSH_DAYS=30

function color() {
    echo -en "\033[31m"  ## red
    eval $* | while read line; do
        echo -en "\033[32m"  ## green
        echo $line
        echo -en "\033[31m"  ## red
    done
    echo -en "\033[0m" 
}

 
# TODO implement this
# emacsclient --insert <(<command>)

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

export HISTTIMEFORMAT='%F %T  '

plugins=( zsh-syntax-highlighting )

##########################################
# UNCOMitted
##########################################
 alias cbt='/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin/cbt'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
