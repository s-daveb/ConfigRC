#!/usr/bin/env zsh

NVIM_PATH="$(brew --prefix neovim)/bin"
NVIMQT_PATH="$(brew --prefix neovim-qt)/bin"

export PATH="${NVIMQT_PATH}:${NVIM_PATH}:${PATH}"

