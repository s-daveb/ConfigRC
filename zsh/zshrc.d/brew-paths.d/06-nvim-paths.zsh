#!/usr/bin/env zsh

NVIM_PATH="$(brew --prefix neovim)/bin"
NVIMQT_PATH="$(brew --prefix neovim-qt)/bin"
NEOVIDE_PATH="$(brew --prefix neovide)/bin"

export PATH="${NVIMQT_PATH}:${NVIM_PATH}:${PATH}"

