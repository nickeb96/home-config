#!/bin/sh


git submodule init
git submodule update


# bash
if command -v bash >/dev/null ; then
    if ! test -e ~/.bashrc ; then
        echo 'linking ~/.bashrc' >&2
        ln -s .config/misc/bashrc ~/.bashrc
    else
        echo '~/.bashrc already exists' >&2
    fi
fi


# zsh
if command -v zsh >/dev/null ; then
    if ! test -e ~/.zshrc ; then
        echo 'linking ~/.zshrc' >&2
        ln -s .config/misc/zshrc ~/.zshrc
    else
        echo '~/.zshrc already exists' >&2
    fi
fi


# vim
if command -v vim >/dev/null && ! command -v nvim >/dev/null ; then
    if ! test -e ~/.vimrc ; then
        echo 'linking ~/.vimrc' >&2
        ln -s .config/misc/vimrc ~/.vimrc
    fi
fi


# ssh
if ! test -e ~/.ssh/config ; then
    echo 'creating ~/.ssh/config with "Include ~/.config/ssh/config"' >&2
    printf '%s\n\n' 'Include ~/.config/ssh/config' >~/.ssh/config
elif ! grep --quiet '\bInclude ~/\.config/ssh/config\b' ~/.ssh/config ; then
    echo 'adding "Include ~/.config/ssh/config" to ~/.ssh/config' >&2
    printf '\n\n%s\n\n' 'Include ~/.config/ssh/config' >>~/.ssh/config
else
    echo '~/.ssh/config already has "Include ~/.config/ssh/config"' >&2
fi
mkdir -p ~/.local/state/ssh/sockets || true


# rustfmt fix for mac
if [ "$(uname -s)" = Darwin ] && ! test -e ~/Library/Application\ Support/rustfmt ; then
    echo 'fixing rustfmt config'
    ln -s ../../.config/rustfmt ~/Library/Application\ Support/
fi


# alacritty
if [ "$(uname -s)" = Darwin ] ; then
    if test -d /Applications/Alacritty.app ; then
        alacritty_path=/Applications/Alacritty.app
    elif test -d ~/Applications/Alacritty.app ; then
        alacritty_path=~/Applications/Alacritty.app
    fi
    if test -n "$alacritty_path" ; then 
        echo "setting up alacritty ($alacritty_path)" >&2
        mkdir -p ~/.local/bin || true
        ln -s "$alacritty_path"/Contents/MacOS/alacritty ~/.local/bin/
        mkdir -p ~/.local/share/fish/vendor_completions.d
        ln -s "$alacritty_path"/Contents/Resources/completions/alacritty.fish \
            ~/.local/share/fish/vendor_completions.d/
        mkdir -p ~/.local/share/man/man1 || true
        mkdir -p ~/.local/share/man/man5 || true
        ln -s "$alacritty_path"/Contents/Resources/alacritty.1.gz \
            ~/.local/share/man/man1/alacritty.1.gz
        ln -s "$alacritty_path"/Contents/Resources/alacritty-msg.1.gz \
            ~/.local/share/man/man1/alacritty-msg.1.gz
        ln -s "$alacritty_path"/Contents/Resources/alacritty.5.gz \
            ~/.local/share/man/man5/alacritty.5.gz
        ln -s "$alacritty_path"/Contents/Resources/alacritty-bindings.5.gz \
            ~/.local/share/man/man5/alacritty-bindings.5.gz
        if ! cmp ~/.config/alacritty/icon.icns \
                "$alacritty_path"/Contents/Resources/alacritty.icns >/dev/null ; then
            echo 'changing alacritty icon' >&2
            cp ~/.config/alacritty/icon.icns "$alacrity_path"/Contents/Resources/alacritty.icns
            touch "$alacritty_path"
        fi
    else
        echo 'alacritty is not installed' >&2
    fi
fi


# brew
if [ "$(uname -s)" = Darwin ] && command -v brew >/dev/null ; then
    if ! brew tap | grep --quiet '^homebrew/aliases$' ; then
        echo 'tapping homebrew/aliases'
        brew tap homebrew/aliases
    fi
fi


# docker
if test -d ~/.docker ; then
    if ! test -f ~/.docker/config.json ; then
        echo 'linking ~/.docker/config.json'
        ln -s ../.config/docker/config.json ~/.docker/config.json
    else
        echo '~/.docker/config.json already exists' >&2
    fi
fi

