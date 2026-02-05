#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

BASE16_SHELL="$HOME/.config/base16-shell/" [ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && source "$BASE16_SHELL/profile_helper.sh"

alias pacup='sudo pacman -Syu'
alias pacrm='sudo pacman -Rns'
alias pacorph='pacman -Qtdq | sudo pacman -Rns'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
PS1='[\u@\h \W]\$ '

# Created by `pipx` on 2026-01-11 10:54:14
export PATH="$PATH:$HOME/.local/bin"
