#!/bin/sh


# if command -v git >/dev/null ; then
#     git submodule init
#     git submodule update
# fi


# bash
if command -v bash >/dev/null ; then
    if ! test -e ~/.bashrc ; then
        echo 'linking ~/.bashrc' >&2
        ln -s .config/misc/bashrc ~/.bashrc
    elif ! test -L ~/.bashrc ; then
        echo '~/.bashrc already exists' >&2
    fi
fi


# zsh
if command -v zsh >/dev/null ; then
    if ! test -e ~/.zshrc ; then
        echo 'linking ~/.zshrc' >&2
        ln -s .config/misc/zshrc ~/.zshrc
    elif ! test -L ~/.zshrc ; then
        echo '~/.zshrc already exists' >&2
    fi
fi


# screen
if command -v screen >/dev/null ; then
    if ! test -e ~/.screenrc ; then
        echo 'linking ~/.screenrc' >&2
        ln -s .config/misc/screenrc ~/.screenrc
    elif ! test -L ~/.screenrc ; then
        echo '~/.screenrc already exists' >&2
    fi
fi


# vim
if command -v vim >/dev/null && ! command -v nvim >/dev/null ; then
    if ! test -e ~/.vimrc ; then
        echo 'linking ~/.vimrc' >&2
        ln -s .config/misc/vimrc ~/.vimrc
    elif ! test -L ~/.vimrc ; then
        echo '~/.vimrc already exists' >&2
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
fi
mkdir -p ~/.local/state/ssh/sockets
chmod 700 ~/.local/state/ssh/sockets


# link cargo docs if they're available
if command -v rustup >/dev/null && command -v cargo >/dev/null ; then
    rustup_home="$(rustup show home)"
    toolchain="$(rustup show active-toolchain --verbose | head -n1)"
    cargo_home="${CARGO_HOME:-$HOME/.cargo}"
    if ! test -e "$cargo_home/share" ; then
        echo "linking $cargo_home/share to $rustup_home/toolchains/$toolchain/share" >&2
        ln -s "$rustup_home/toolchains/$toolchain/share" "$cargo_home/share"
    fi
fi


# rustfmt fix for mac
if [ "$(uname -s)" = Darwin ] && ! test -e ~/Library/Application\ Support/rustfmt ; then
    echo 'linking rustfmt config' >&2
    ln -s ../../.config/rustfmt ~/Library/Application\ Support/rustfmt
fi


# ra-multiplex fix for mac
if [ "$(uname -s)" = Darwin ] && ! test -e ~/Library/Application\ Support/ra-multiplex ; then
    echo 'linking ra-multiplex config' >&2
    ln -s ../../.config/ra-multiplex ~/Library/Application\ Support/ra-multiplex
fi


# aerc fix for mac
if [ "$(uname -s)" = Darwin ] && ! test -e ~/Library/Preferences/aerc ; then
    echo 'linking aerc config' >&2
    ln -s ../../.config/aerc ~/Library/Preferences/aerc
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
        alacritty_app_path=/Applications/Alacritty.app
        # local_path=/usr/local
        local_path=~/.local
    elif test -d ~/Applications/Alacritty.app ; then
        alacritty_app_path=~/Applications/Alacritty.app
        local_path=~/.local
    fi
    if test -n "$alacritty_app_path" ; then
        if ! test -e "$local_path"/bin/alacritty ; then
            # echo "linking $local_path/bin/alacritty" >&2
            mkdir -vp "$local_path"/bin
            ln -vs "$alacritty_app_path"/Contents/MacOS/alacritty \
                "$local_path"/bin/alacritty
        fi
        if ! test -e "$local_path"/share/fish/vendor_completions.d/alacritty.fish ; then
            # echo "linking $local_path/share/fish/vendor_completions.d/alacritty.fish" >&2
            mkdir -vp "$local_path"/share/fish/vendor_completions.d
            ln -vs "$alacritty_app_path"/Contents/Resources/completions/alacritty.fish \
                "$local_path"/share/fish/vendor_completions.d/alacritty.fish
        fi
        if ! test -e "$local_path"/share/man/man1/alacritty.1.gz ; then
            # echo "linking $local_path/share/man/man1/alacritty.1.gz" >&2
            mkdir -vp "$local_path"/share/man/man1
            ln -vs "$alacritty_app_path"/Contents/Resources/alacritty.1.gz \
                "$local_path"/share/man/man1/alacritty.1.gz
        fi
        if ! test -e "$local_path"/share/man/man1/alacritty-msg.1.gz ; then
            mkdir -vp "$local_path"/share/man/man1
            ln -vs "$alacritty_app_path"/Contents/Resources/alacritty-msg.1.gz \
                "$local_path"/share/man/man1/alacritty-msg.1.gz
        fi
        if ! test -e "$local_path"/share/man/man5/alacritty.5.gz ; then
            mkdir -vp "$local_path"/share/man/man5
            ln -vs "$alacritty_app_path"/Contents/Resources/alacritty.5.gz \
                "$local_path"/share/man/man5/alacritty.5.gz
        fi
        if ! test -e "$local_path"/share/man/man5/alacritty-bindings.5.gz ; then
            mkdir -vp "$local_path"/share/man/man5
            ln -vs "$alacritty_app_path"/Contents/Resources/alacritty-bindings.5.gz \
                "$local_path"/share/man/man5/alacritty-bindings.5.gz
        fi
        if ! test -e "$local_path"/share/man/man7/alacritty-escapes.7.gz ; then
            mkdir -vp "$local_path"/share/man/man7
            ln -vs "$alacritty_app_path"/Contents/Resources/alacritty-escapes.7.gz \
                "$local_path"/share/man/man7/alacritty-escapes.7.gz
        fi
        if ! cmp -s ~/.config/alacritty/icon.icns "$alacritty_app_path"/Contents/Resources/alacritty.icns ; then
            echo 'changing alacritty icon' >&2
            cp ~/.config/alacritty/icon.icns "$alacritty_app_path"/Contents/Resources/alacritty.icns
            touch "$alacritty_app_path"
            killall Dock Finder
        fi
    fi
fi


# brew
if [ "$(uname -s)" = Darwin ] && command -v brew >/dev/null ; then
    if test -z "$(brew alias show)" ; then
        echo 'aliasing brew show as brew info' >&2
        brew alias show=info
    fi
fi


# docker
if test -d ~/.docker ; then
    if ! test -f ~/.docker/config.json ; then
        echo 'linking ~/.docker/config.json' >&2
        ln -s ../.config/docker/config.json ~/.docker/config.json
    fi
fi

