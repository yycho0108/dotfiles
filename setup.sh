#!/usr/bin/env bash

list_dotfiles(){
    # NOTE(ycho): Find repository in a somewhat robust manner.
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    DIR="$(readlink -f $DIR)"

    #find . -maxdepth 1 -type f -name '\.*' -exec sh -c '
    #for f do
    #    git check-ignore -q "$f" || echo $f
    #done
    #' find-sh {} +

    echo "${DIR}/.bashrc"
    echo "${DIR}/.vimrc"
    echo "${DIR}/.inputrc"
    echo "${DIR}/.python_startup.py"
}

for src in $(list_dotfiles); do
    dst="$HOME/$(basename $src)"
    if [ -f "$dst" ]; then
        rm -i "$dst"
    fi
    ln -sv "$(realpath $src)" "$dst"
done
