#!/bin/bash

# =========================================================================
# TruthByte Installation Script
#
# This script installs TruthByte to the system, sets up aliases, and
# installs the man page documentation.
# =========================================================================

# Exit immediately if any command fails
set -e

# === Define color codes for better readability ===
GREEN='\033[0;32m'  # Success messages
RED='\033[0;31m'    # Error messages  
NC='\033[0m'        # No Color - resets formatting

# === Helper Functions ===
error_exit() {
    # Display error message and exit with failure status
    # Params:
    #   $1: Error message to display
    echo -e "${RED}Error: $1${NC}" >&2
    exit 1
}

add_alias() {
    # Add the 'tb' alias to various shell configuration files
    # This ensures the alias is available in different shell environments
    local alias_cmd="alias tb=truthbyte"
    for file in "$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.profile" "$HOME/.bash_profile"; do
        # Only add the alias if the file exists and doesn't already have it
        if [ -f "$file" ] && ! grep -q "$alias_cmd" "$file"; then
            echo "$alias_cmd" >> "$file"
            echo -e "${GREEN}Added alias to $file${NC}"
        fi
    done
}

reload_shell_config() {
    # Reload the current shell configuration to make the alias available immediately
    # Detects whether running in Bash or Zsh and sources the appropriate file
    if [ -n "$ZSH_VERSION" ]; then
        source "$HOME/.zshrc" || echo -e "${RED}Failed to reload .zshrc${NC}"
    elif [ -n "$BASH_VERSION" ]; then
        source "$HOME/.bashrc" || echo -e "${RED}Failed to reload .bashrc${NC}"
    fi
}

# === Main Installation Process ===
echo -e "${GREEN}Installing TruthByte...${NC}"

# Ensure script is run with root privileges to write to system directories
if [ "$EUID" -ne 0 ]; then
    error_exit "This script must be run as root. Use 'sudo ./install.sh'."
fi

# Check if this is a new installation or an update
if [ -f "/usr/local/bin/truthbyte" ]; then
    echo "TruthByte already exists, updating..."
else
    echo "Installing TruthByte for the first time..."
fi

# Create required directories if they don't exist
mkdir -p /usr/local/bin
mkdir -p /usr/local/share/man/man1

# Copy the main script to binary directory and make it executable
cp truthbyte.sh /usr/local/bin/truthbyte || error_exit "Failed to copy truthbyte.sh to /usr/local/bin"
chmod +x /usr/local/bin/truthbyte || error_exit "Failed to make /usr/local/bin/truthbyte executable"

# Create the 'tb' shorthand alias in user's shell config files
add_alias

# Install and set up the man page documentation
cp man/truthbyte.1 /usr/local/share/man/man1/ || error_exit "Failed to copy man page"
gzip -f /usr/local/share/man/man1/truthbyte.1 || error_exit "Failed to compress man page"
mandb || echo -e "${RED}Failed to update man database. You may need to run 'sudo mandb' manually.${NC}"

# Attempt to make the alias available in the current session
reload_shell_config

# Display success message with usage instructions
echo -e "${GREEN}TruthByte installed successfully!${NC}"
echo -e "${GREEN}You can now use 'truthbyte' or 'tb' from the command line.${NC}"