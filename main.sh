#!/bin/bash

# Create necessary library symlinks FIRST
sudo ln -sf /usr/lib/x86_64-linux-gnu/libwebkit2gtk-4.1.so.0 /usr/lib/x86_64-linux-gnu/libwebkit2gtk-4.0.so.37
sudo ln -sf /usr/lib/x86_64-linux-gnu/libjavascriptcoregtk-4.1.so.0 /usr/lib/x86_64-linux-gnu/libjavascriptcoregtk-4.0.so.18

# Set some colors for output messages
OK="$(tput setaf 2)[OK]$(tput sgr0)"
ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
NOTE="$(tput setaf 3)[NOTE]$(tput sgr0)"
INFO="$(tput setaf 4)[INFO]$(tput sgr0)"
WARN="$(tput setaf 1)[WARN]$(tput sgr0)"
CAT="$(tput setaf 6)[ACTION]$(tput sgr0)"
MAGENTA="$(tput setaf 5)"
ORANGE="$(tput setaf 214)"
WARNING="$(tput setaf 1)"
YELLOW="$(tput setaf 3)"
GREEN="$(tput setaf 2)"
BLUE="$(tput setaf 4)"
SKY_BLUE="$(tput setaf 6)"
RESET="$(tput sgr0)"

# Function to print colorful text
print_color() {
    printf "%b%s%b\n" "$1" "$2" "$RESET"
}

# Display warning banner
printf "\n%.0s" {1..2}
print_color "$WARNING" "
    █▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█
                get bamboo slicer on ubuntu
              
                            NOTICE
    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█

    This script installs Bamboo Studio (Slicer) on Ubuntu 24.04 LTS.
    The official version does not currently work out of the box on Ubuntu 24.04.
    This workaround symlinks libraries and installs dependencies.
    It will install the official AppImage version.
"

# Update and install dependencies
print_color "$CAT" "Updating APT and installing required dependencies..."
sudo apt update
sudo apt install -y wget libfuse2 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 \
    libxcb-render-util0 libxcb-xinerama0 libxkbcommon-x11-0

# Download Bamboo Studio AppImage
print_color "$CAT" "Downloading Bamboo Studio AppImage..."
wget https://github.com/bambulab/BambuStudio/releases/latest/download/BambuStudio-ubuntu-64bit.AppImage -O BambuStudio.AppImage

# Make AppImage executable
chmod +x BambuStudio.AppImage

# Move to /usr/local/bin
print_color "$CAT" "Installing Bamboo Studio to /usr/local/bin as 'bambu-studio'..."
sudo mv BambuStudio.AppImage /usr/local/bin/bambu-studio

# Launch
print_color "$OK" "Installation complete. Launching Bamboo Studio..."
bambu-studio
