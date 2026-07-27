#!/bin/bash

# Define the options
lock="  lock"
suspend="  suspend"
logout="  logout"
reboot="  reboot"
shutdown="  shutdown"

# Helper function to gracefully close all Wayland applications
graceful_exit() {
    # 1. Fetch all window addresses
    local clients
    clients=$(hyprctl clients -j | jq -r '.[].address')

    # If no windows are open, return success immediately
    if [ -z "$clients" ]; then
        return 0
    fi

    # 2. Iterate through the addresses and send a proper Wayland close signal
    for win in $clients; do
	hyprctl dispatch "hl.dsp.window.close({ window = \"address:$win\" })"
    done

    # 3. Wait and check if applications actually closed (max 10 seconds)
    local timeout=10
    local count=0

    while [ "$count" -lt "$timeout" ]; do
        local remaining
        remaining=$(hyprctl clients -j | jq '. | length')

        # If 0 windows remain, success!
        if [ "$remaining" -eq 0 ]; then
            return 0
        fi

        sleep 1
        count=$((count + 1))
    done

    # 4. Timeout reached: applications are refusing to close (e.g., unsaved work)
    notify-send -u critical "Action Aborted" "An application is waiting for confirmation."
    return 1
}

# Pass options to Wofi and capture the output
# --dmenu: Reads from standard input
# --prompt: Sets the text in the search bar
choice=$(echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | wofi --dmenu --prompt "POWER MENU" --conf ~/.config/wofi/config.powermenu)

# Execute the corresponding command based on the choice
case $choice in
    $lock)
        hyprlock
	;;
    $suspend)
        hyprlock
	systemctl suspend 
	;;
    $logout)
	graceful_exit && 
	uwsm stop
	;;
    $reboot)
	graceful_exit && 
        systemctl reboot 
	;;
    $shutdown)
	graceful_exit && 
        systemctl poweroff 
	;;
esac
