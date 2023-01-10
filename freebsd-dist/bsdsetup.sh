#!/bin/sh

pkg upgrade -y pkg
pkg install -y bash zsh vim doas mosh tmux git python3

# Get iocage
exact_iocage_pkg="$(pkg search -x "py([0123456789]{2,3})-iocage-([0123456789])(.*)" | awk '{ print $1 }')"

pkg install -y ${exact_iocage_pkg}
