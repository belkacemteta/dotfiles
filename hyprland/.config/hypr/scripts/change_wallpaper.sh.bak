#!/bin/bash

# Directory containing your wallpapers
DIR="$HOME/.local/share/wallpapers"

# Find all images and GIFs, then shuffle to pick one randomly
WP=$(ls "$DIR" | shuf -n 1)
WP="$DIR/$WP"

# Ensure the swww daemon is running
if ! pgrep -x "awww-daemon" > /dev/null; then
    uwsm app -- awww-daemon
    sleep 1
fi

# Apply the wallpaper with a brutalist "wipe" transition
# --transition-type: wipe, outer, center, wave, etc.
awww img "$WP" \
    --transition-type wipe \
    --transition-angle 30 \
    --transition-step 90 \
    --transition-fps 60
