#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e 

# Global Variables

echo "Starting installation..."

# 1. Update the system
sudo pacman -Syu --noconfirm

# 2. Install Chaotic-AUR if not available

# 3. Read pkglist.txt and install packages
echo "Installing packages from pkglist.txt..."
pacman -S --needed --noconfirm - < pkglist.txt

# 4. Enabling systemd user services
echo "Enabling background services..."

# 5. Stow your configurations
echo "Symlinking dotfiles with Stow..."

stow hyprland
stow waybar
stow terminal
stow bash

echo "Setup complete. Reboot? [Y/n] "
