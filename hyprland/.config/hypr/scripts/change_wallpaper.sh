#!/usr/bin/env bash

# ---------------------------------------------------------
# Configuration
# ---------------------------------------------------------
WALLPAPER_DIR="$HOME/.local/share/wallpapers"
SYMLINK_PATH="$HOME/.config/hypr/wallpaper"
DAEMON="awww"

# ---------------------------------------------------------
# 2. Gather all wallpapers into an array (Fixed Sorting)
# ---------------------------------------------------------
# 'extglob' allows us to match multiple extensions at once
# so Bash sorts them strictly alphabetically by filename.
shopt -s nullglob nocaseglob extglob
wallpapers=("$WALLPAPER_DIR"/*.@(jpg|jpeg|png|gif|webp))
shopt -u nullglob nocaseglob extglob

if [[ ${#wallpapers[@]} -eq 0 ]]; then
    echo "Error: No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

# ---------------------------------------------------------
# 3. Cycling Logic (Fixed Path Matching)
# ---------------------------------------------------------
current_wallpaper_name=""

# If the symlink exists, just grab the actual filename it points to
if [[ -L "$SYMLINK_PATH" ]]; then
    current_wallpaper_name=$(basename "$(realpath "$SYMLINK_PATH")")
fi

next_index=0 # Default to the first wallpaper

# Compare just the filenames (basename) instead of the full path
for i in "${!wallpapers[@]}"; do
    if [[ "$(basename "${wallpapers[$i]}")" == "$current_wallpaper_name" ]]; then
        next_index=$(( (i + 1) % ${#wallpapers[@]} ))
        break
    fi
done

next_wallpaper="${wallpapers[$next_index]}"

# ---------------------------------------------------------
# 4. Apply the wallpaper and update symlink
# ---------------------------------------------------------
# Change the wallpaper (you can add transition flags here if you like)
$DAEMON img "$next_wallpaper" \
    --transition-type wipe \
    --transition-angle 30 \
    --transition-step 90 \
    --transition-fps 60

# Force-create the symlink pointing to the new wallpaper
ln -sf "$next_wallpaper" "$SYMLINK_PATH"

echo "Switched to: $(basename "$next_wallpaper")"
