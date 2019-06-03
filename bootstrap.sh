#!/bin/bash

git clone --recursive git://github.com/ljrickard/dotfiles.git $HOME/.dotfiles 2> /dev/null && echo "Cloned dotfiles" || echo "dotfiles already exist"

read -rp "Install homebrew and some useful packages? " b_yn
case $b_yn in
    [Yy]* )
        which brew || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew tap caskroom/cask
        # brew install brew-cask
        while read -r line
        do
            # brew install "$line"
            echo $line
        done < frozen.brew
        while read -r line
        do
            HOMEBREW_CASK_OPTS="--appdir=/Applications" brew cask install "${line}"
        done < frozen.cask
        ;;
    [Nn]* )
        echo "OK, not installing..."
        ;;
esac


read -rp "Replace old dot files? " b_yn
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


read -rp "Changing default shell to zsh, OK? " yn
case $yn in
    [Yy]* ) chsh -s "$(which zsh)"; ;;
esac

read -rp "Replace old dot files? " b_yn
case $b_yn in
    [Yy]* )
    if [[ $(uname) == 'Darwin' ]]; then
        # echo "Installing Monaco Powerline font - click install"
        # open Monaco-Powerline.otf

        echo "Installing custom iTerm2 color theme"
        open iterm2.itermcolors
    fi
esac
