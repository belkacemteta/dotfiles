
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# --- History Settings ---
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory # Shares history across multiple terminal windows

# --- Aliases ---
alias ls='ls --color=auto -h'
alias ll='ls --color=auto -hl'
alias la='ls --color=auto -hla'
alias grep='grep --color=auto'

alias u='sudo pacman -Syu'
alias i='sudo pacman -S --needed '
alias r='sudo pacman -Rs '

alias rm='rm -rI '
alias trash="mv -t $HOME/.trash "
alias mv='mv -i '

alias restart='sudo shutdown -r now'

# --- Set some apps to run without padding ---
run_without_padding() {
    kitty @ set-spacing padding=0
    "$@"
    kitty @ set-spacing padding=default
}
alias nvim="run_without_padding nvim"
alias htop="run_without_padding htop"
alias ranger="run_without_padding ranger"
alias lazygit="run_without_padding lazygit"

set -o vi

# --- Plugins ---
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# --- Prompt ---
# Initialize Starship
eval "$(starship init zsh)"
