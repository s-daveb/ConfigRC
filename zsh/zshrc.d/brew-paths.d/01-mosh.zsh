#!/usr/bin/env zsh

mosh_install="$(brew --prefix mosh)"
PATH="$(prepend_path ${mosh_install}/bin ${PATH})"

export PATH
