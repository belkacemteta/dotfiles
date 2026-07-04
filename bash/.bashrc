#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto -h'
alias ll='ls --color=auto -hl'
alias la='ls --color=auto -hla'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '


alias u='sudo pacman -Syu'
alias i='sudo pacman -S '
alias r='sudo pacman -Rs '

alias rm='rm -rI '
alias trash="mv -t $HOME/.trash "
alias mv='mv -i '


set -o vi
