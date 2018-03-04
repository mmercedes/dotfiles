#!/bin/bash

# matches all files starting with . followed by alphanumeric char
for file in \.[[:alnum:]]*
do
    if [ "$file" == ".git" ] || [ "$file" == ".gitignore" ]; then
        continue
    fi

    if [ -e "$HOME/$file" ]; then
        read -p "$HOME/$file already exists. Overwrite with $(pwd)/$file (y/N)? " -n 1 choice
    else
        read -p "Symlink $(pwd)/$file to $HOME/$file (y/n)? " -n 1 choice
    fi

    case $choice in
        y|Y ) rm -rf "$HOME/$file" && ln -s "$(pwd)/$file" "$HOME/$file" && echo "\n linked $file";;
        * ) echo "" && continue;;
    esac
done
