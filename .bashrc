#!/usr/bin/env bash
# NOTE: source order is important!

# Figure out ROOT directory.
export DOTROOT=$(dirname $(realpath "$HOME/.bashrc"))

# Generic order-independent setup files.
for rcfile in "${DOTROOT}/bashrc.d/"*.sh.in; do
    source "${rcfile}";
done
