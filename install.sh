#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e 

# --- Color Palette for Clean Layout ---
NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'

# --- UI Helper Functions ---
print_step() {
    echo -e "\n${CYAN}==================================================${NC}"
    echo -e "${PURPLE}🚀 $1${NC}"
    echo -e "${CYAN}==================================================${NC}"
}

print_success() { echo -e "${GREEN}✔ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
print_error()   { echo -e "${RED}✘ $1${NC}"; }
print_info()    { echo -e "${BLUE}ℹ $1${NC}"; }

# Global Variables
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

# Elevate privileges early
print_info "Requesting administrative privileges..."
sudo -v || { print_error "Failed to obtain sudo privileges. Exiting."; exit 1; }

# Keep-alive sudo loop in the background so it doesn't timeout during large installs
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

print_step "Starting Installation"

# 1. Update the system
print_info "Updating system databases and packages..."
sudo pacman -Syu --noconfirm
print_success "System packages updated."

# 2. Install Chaotic-AUR if not available
print_step "Checking Chaotic-AUR Configuration"
if grep -q "^\[chaotic-aur\]" /etc/pacman.conf; then
    print_success "Chaotic AUR is already configured on this system."
else
    print_info "Chaotic-AUR not detected. Setting it up now..."
    
    sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
    sudo pacman-key --lsign-key 3056513887B78AEB
    sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
    sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
    
    sudo tee -a /etc/pacman.conf > /dev/null << 'EOF'

[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOF

    if sudo pacman -Sy --noconfirm; then
        print_success "Chaotic AUR has been safely installed and synced."
    else
        print_error "Repository added, but database sync failed."
    fi
fi

# 3. Read pkglist and install packages safely
print_step "Installing Packages"
# This extracts all packages, safely ignoring blank lines and lines starting with '#'
PKG_LIST=$(grep -hv -e '^[[:space:]]*#' -e '^[[:space:]]*$' "$SCRIPT_DIR"/installation/packages/*.txt 2>/dev/null || true)

if [ -n "$PKG_LIST" ]; then
    print_info "Syncing requested packages via pacman..."
    echo "$PKG_LIST" | xargs sudo pacman -S --needed --noconfirm
    print_success "All system packages installed successfully."
else
    print_warning "No packages found inside the installation/packages/ directory."
fi

# 4. Enabling systemd user services
print_step "Enabling Background Services"
SERVICES_FILE="$SCRIPT_DIR/installation/autostart-services.txt"
if [ -f "$SERVICES_FILE" ]; then
    SERVICES=$(grep -hv -e '^[[:space:]]*#' -e '^[[:space:]]*$' "$SERVICES_FILE" || true)
    if [ -n "$SERVICES" ]; then
        print_info "Enabling user-level systemd services..."
        # Enabled with a fallback check in case dbus isn't active yet in a minimal tty environment
        systemctl --user enable $SERVICES || print_warning "Some user services couldn't bind. They will run upon desktop login."
        print_success "Services marked for autostart."
    else
        print_info "No services found in $SERVICES_FILE."
    fi
else
    print_warning "$SERVICES_FILE missing. Skipping configuration."
fi

# 5. Installing Graphite GTK Theme
print_step "Building Neobrutalist GTK Theme (Graphite)"

# We clone into /tmp so the raw files clean themselves up on reboot
THEME_DIR="/tmp/Graphite-gtk-theme"
if [ ! -d "$THEME_DIR" ]; then
    print_info "Cloning Graphite repository..."
    git clone --depth=1 https://github.com/vinceliuice/Graphite-gtk-theme.git "$THEME_DIR"
    
    cd "$THEME_DIR" || exit
    print_info "Compiling theme with sharp edges and dark contrast..."
    
    ./install.sh --round 0px --tweaks black rimless normal
    
    # Link it to flatpak apps if you ever use them
    sudo flatpak override --filesystem=xdg-config/gtk-4.0 || true
    
    cd "$SCRIPT_DIR" || exit
    print_success "Graphite theme built and installed locally."
else
    print_success "Graphite theme already present in /tmp."
fi

# 6. Stow Helper Function (Handles updates & file conflicts)
backup_and_stow() {
    local pkg="$1"
    local target_dir="$HOME"
    local source_dir="$SCRIPT_DIR/$pkg"

    print_info "Deploying package symlinks: [ $pkg ]"

    if [ ! -d "$source_dir" ]; then
        print_error "Package directory '$source_dir' missing! Skipping."
        return 1
    fi

    # -R (restow) clears out dead/changed elements and forces an active update sync
    stow -R -v 2 -t "$target_dir" -d "$SCRIPT_DIR" "$pkg"
    print_success "Package [ $pkg ] synced cleanly."
}

print_step "Symlinking Dotfiles via GNU Stow"
# Ensure stow is ready
if ! command -v stow &> /dev/null; then
    sudo pacman -S --needed --noconfirm stow
fi

backup_and_stow "scripts"
backup_and_stow "hyprland"
backup_and_stow "bar"
backup_and_stow "terminal"
backup_and_stow "wofi"
backup_and_stow "uwsm"
backup_and_stow "fontconfig"
backup_and_stow "gtk"
backup_and_stow "qt"
backup_and_stow "wallpapers"

# 7. Change default shell to Zsh
print_step "Changing Default Shell"
if [ "$SHELL" != "/usr/bin/zsh" ]; then
    print_info "Changing default shell to zsh for $USER..."
    # 'chsh' requires a password unless run as root. We use sudo usermod to bypass the prompt cleanly in the script.
    sudo usermod -s /usr/bin/zsh "$USER"
    print_success "Default shell changed to Zsh."
else
    print_success "Zsh is already the default shell."
fi

# 8. Complete and Reboot Execution
print_step "Installation Complete!"
read -rp "Would you like to reboot your machine right now? [y/N]: " choice
case "$choice" in
    [yY][eE][sS]|[yY]) 
        print_info "Rebooting system..."
        sudo reboot
        ;;
    *)
        print_success "All done! Please reload your shell or reboot manually when convenient."
        ;;
esac
