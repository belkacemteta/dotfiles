#!/bin/bash

# Check if waybar is running
if pkill -0 waybar; then
    # If it is running, kill it (hides the bar)
    pkill waybar
else
    # If it's not running, start a new instance (shows and reloads it)
    waybar &
fi
