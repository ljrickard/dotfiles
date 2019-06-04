#!/bin/bash

# this is not working too well - failed to clone recursively
# git clone --recursive git://github.com/ljrickard/dotfiles.git $HOME/.dotfiles 2> /dev/null && echo "Cloned dotfiles" || echo "dotfiles already exist"
git submodule update --init --recursive

read -rp "Install homebrew and some useful packages? " b_yn
case $b_yn in
    [Yy]* )
        which brew || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew tap caskroom/cask
        while read -r line
        do
            brew install "$line"
        done < frozen.brew
        while read -r line
        do
            HOMEBREW_CASK_OPTS="--appdir=/Applications" brew cask install "${line}"
        done < frozen.cask
        ;;
esac


read -rp "Create symbolic links to files? " b_yn
case $b_yn in
    [Yy]* )
    epoch=$(date +"%s")
    for i in $HOME/.zshrc $HOME/.screenrc; do
        if [[ ( -e $i ) || ( -h $i ) ]]; then
            echo "renaming ${i} to ${i}.old"
            mv "${i}" "${i}.${epoch}.old" || die "Could not move ${i} to ${i}.old"
        fi
    done

    ln -sfv ${PWD}/zshrc ${HOME}/.zshrc
    ln -sfv ${PWD}/screenrc ${HOME}/.screenrc
esac


read -rp "Change default shell to zsh? " yn
case $yn in
    [Yy]* ) chsh -s "$(which zsh)"; ;;
esac

read -rp "Replace old dot files? " b_yn
case $b_yn in
    [Yy]* )
    if [[ $(uname) == 'Darwin' ]]; then
        echo "Installing custom iTerm2 color theme"
        open iterm2.itermcolors
    fi
esac
