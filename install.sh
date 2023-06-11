#!/bin/bash

###
# Instal brew packages:
# 
##

if [ -e "$(pwd)/.oh-my-zsh/custom/plugins" ]; then
    echo "linking ./zsh_plugins to ./.oh-my-zsh/custom/plugins"
    ln -sf ./zsh_plugins/* ./.oh-my-zsh/custom/plugins/
fi

# matches all files starting with . followed by alphanumeric char
for file in \.[[:alnum:]]*
do
    if [ "$file" == ".git" ] || [ "$file" == ".gitignore" ] || [ "$file" == ".gitmodules" ]; then
        continue
    fi

    if [ ! -L "$HOME/$file" ]; then
        read -p "$HOME/$file already exists and is NOT a symlink. Overwrite with $(pwd)/$file (y/N)? " -n 1 choice
    else
        choice="y"
    fi

    case $choice in
        y|Y ) rm -rf "$HOME/$file" && ln -s "$(pwd)/$file" "$HOME/$file" && echo "linked $file";;
        * ) echo "" && continue;;
    esac
done
