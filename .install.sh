#!/bin/sh


if command -v git >/dev/null ; then
    # git submodule init
    # git submodule update
fi


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


# screen
if command -v screen >/dev/null ; then
    if ! test -e ~/.screenrc ; then
        echo 'linking ~/.screenrc' >&2
        ln -s .config/misc/screenrc ~/.screenrc
    else
        echo '~/.screenrc already exists' >&2
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
    if ! test -d ~/.ssh ; then
        mkdir -m 700 ~/.ssh
    fi
    echo 'creating ~/.ssh/config with "Include ~/.config/ssh/config"' >&2
    printf '%s\n' 'Include ~/.config/ssh/config' >~/.ssh/config
    chmod 600 ~/.ssh/config
elif ! grep --quiet '\bInclude ~/\.config/ssh/config\b' ~/.ssh/config ; then
    echo 'adding "Include ~/.config/ssh/config" to ~/.ssh/config' >&2
    printf '\n\n%s\n\n' 'Include ~/.config/ssh/config' >>~/.ssh/config
else
    echo '~/.ssh/config already has "Include ~/.config/ssh/config"' >&2
fi
mkdir -p ~/.local/state/ssh/sockets
chmod 700 ~/.local/state/ssh/sockets


# rustfmt fix for mac
if [ "$(uname -s)" = Darwin ] && ! test -e ~/Library/Application\ Support/rustfmt ; then
    echo 'linking rustfmt config' >&2
    ln -s ../../.config/rustfmt ~/Library/Application\ Support/rustfmt
fi


# keybindings for mac
if [ "$(uname -s)" = Darwin ] && ! test -e ~/Library/KeyBindings/DefaultKeyBinding.dict ; then
    echo 'copying DefaultKeyBinding.dict to ~/Library/KeyBindings' >&2
    mkdir -p ~/Library/KeyBindings
    cp ~/.config/macos/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict
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
        if ! test -e ~/.local/bin/alacritty ; then
            mkdir -vp ~/.local/bin
            ln -vs "$alacritty_path"/Contents/MacOS/alacritty ~/.local/bin/alacritty
        fi
        if ! test -e ~/.local/share/fish/vendor_completions.d/alacritty.fish ; then
            mkdir -vp ~/.local/share/fish/vendor_completions.d
            ln -vs "$alacritty_path"/Contents/Resources/completions/alacritty.fish \
                ~/.local/share/fish/vendor_completions.d
        fi
        if ! test -e ~/.local/share/man/man1/alacritty.1.gz ; then
            mkdir -vp ~/.local/share/man/man1
            ln -vs "$alacritty_path"/Contents/Resources/alacritty.1.gz \
                ~/.local/share/man/man1/alacritty.1.gz
        fi
        if ! test -e ~/.local/share/man/man1/alacritty-msg.1.gz ; then
            mkdir -vp ~/.local/share/man/man1
            ln -vs "$alacritty_path"/Contents/Resources/alacritty-msg.1.gz \
                ~/.local/share/man/man1/alacritty-msg.1.gz
        fi
        if ! test -e ~/.local/share/man/man5/alacritty.5.gz ; then
            mkdir -vp ~/.local/share/man/man5
            ln -vs "$alacritty_path"/Contents/Resources/alacritty.5.gz \
                ~/.local/share/man/man5/alacritty.5.gz
        fi
        if ! test -e ~/.local/share/man/man5/alacritty-bindings.5.gz ; then
            mkdir -vp ~/.local/share/man/man5
            ln -vs "$alacritty_path"/Contents/Resources/alacritty-bindings.5.gz \
                ~/.local/share/man/man5/alacritty-bindings.5.gz
        fi
        if ! cmp ~/.config/alacritty/icon.icns "$alacritty_path"/Contents/Resources/alacritty.icns >/dev/null ; then
            echo 'changing alacritty icon' >&2
            cp ~/.config/alacritty/icon.icns "$alacritty_path"/Contents/Resources/alacritty.icns
            touch "$alacritty_path"
            killall Dock Finder
        fi
    else
        echo 'alacritty is not installed' >&2
    fi
fi


# brew
if [ "$(uname -s)" = Darwin ] && command -v brew >/dev/null ; then
    if test -z "$(brew alias show)" ; then
        echo 'aliasing brew show as brew info'
        brew alias show=info
    fi
    if ! brew tap | grep --quiet '^homebrew/command-not-found$' ; then
        echo 'tapping homebrew/command-not-found' >&2
        brew tap homebrew/command-not-found
    fi
fi


# docker
if test -d ~/.docker ; then
    if ! test -f ~/.docker/config.json ; then
        echo 'linking ~/.docker/config.json' >&2
        ln -s ../.config/docker/config.json ~/.docker/config.json
    else
        echo '~/.docker/config.json already exists' >&2
    fi
fi

