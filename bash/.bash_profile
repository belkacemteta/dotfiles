#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# If we are on TTY1 (the default local login console), start Hyprland
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    if uwsm check may-start; then
        exec uwsm start hyprland-uwsm.desktop
    fi
fi
