set -g fish_greeting

alias ll="ls -lh"
alias la="ls -A"
alias gs="git status"

zoxide init fish | source
fzf --fish | source
