#!/bin/bash

git clone --recursive git://github.com/ceocoder/dotfiles.git $HOME/.dotfiles && echo "Cloned dotfiles" || echo "Looks like dotfiles exist"

if [[ $(uname) == 'Darwin' ]]; then
    echo "Mac OS X detected: installing homebrew"
    read -rp "Mac OS X detected: install homebrew and some useful packages? " b_yn
    case $b_yn in
        [Yy]* )
            which brew || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            brew tap caskroom/cask
            brew install brew-cask
            while read -r line
            do
                brew install "$line"
            done < frozen.brew
            while read -r line
            do
                HOMEBREW_CASK_OPTS="--appdir=/Applications" brew cask install "${line}"
            done < frozen.cask
            ;;
        [Nn]* )
            echo "OK, not installing"
            ;;
    esac
else
    read -rp "Install zsh, vim? " t_yn
    case $t_yn in
        [Yy]* )
            case $(lsb_release -i | cut -d':' -f2 | tr -d '\t') in
                'CentOS')
                    sudo yum install zsh vim
                    ;;
                'Debian'|'Ubuntu')
                    sudo apt-get install zsh vim
                    ;;
            esac
            ;;
        [Nn]* )
            echo "Not installing zsh"
            ;;
    esac
    echo "Seems like you are using this not on a Mac"
    echo "Disabling userspace reattatch"
fi

epoch=$(date +"%s")
for i in $HOME/.zshrc $HOME/.screenrc; do
    if [[ ( -e $i ) || ( -h $i ) ]]; then
        echo "renaming ${i} to ${i}.old"
        mv "${i}" "${i}.${epoch}.old" || die "Could not move ${i} to ${i}.old"
    fi
done

ln -sfv ${PWD}/zshrc ${HOME}/.zshrc
ln -sfv ${PWD}/screenrc ${HOME}/.screenrc

read -rp "Changing default shell to zsh, OK? " yn
case $yn in
    [Yy]* ) chsh -s "$(which zsh)"; ;;
    [Nn]* ) echo "Ok"; ;;
esac

if [[ $(uname) == 'Darwin' ]]; then
    echo "Installing Monaco Powerline font - click install"
    open Monaco-Powerline.otf

    echo "Installing custom iTerm2 color theme"
    open iterm2.itermcolors
fi

