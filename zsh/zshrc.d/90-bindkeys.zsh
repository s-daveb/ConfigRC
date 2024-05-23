#!/usr/bin/env zsh

bindkey -e

#bindkey 'OH'    beginning-of-line
#bindkey 'OF'    end-of-line

bindkey '[1~' beginning-of-line
bindkey '[4~' end-of-line


bindkey '[1;5C' forward-word
bindkey '[1;5D' backward-word

bindkey '[3~'	delete-char
