#!/bin/bash

set -e

# Colors
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}Installing TruthByte...${NC}"

# Check if it already installed or not
if [ -f "/usr/local/bin/truthbyte" ]; then
    echo "📄 TruthByte already exists, updating..."
else
    echo "🆕 Installing TruthByte for the first time..."
fi


# Ensure directories
sudo mkdir -p /usr/local/bin
sudo mkdir -p /usr/local/share/man/man1

# Copy the main script
sudo cp truthbyte.sh /usr/local/bin/truthbyte
sudo chmod +x /usr/local/bin/truthbyte

# Add alias to all relevant shell configs
for file in "$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.profile" "$HOME/.bash_profile"; do
    if ! grep -q "alias tb=truthbyte" "$file" 2>/dev/null; then
        echo "alias tb=truthbyte" >> "$file"
    fi
done

# Optional: Source the current shell config
if [ -n "$ZSH_VERSION" ]; then
    source "$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    source "$HOME/.bashrc"
fi

# Install man page
sudo cp man/truthbyte.1 /usr/local/share/man/man1/
sudo gzip -f /usr/local/share/man/man1/truthbyte.1
sudo mandb

echo -e "${GREEN}✅ TruthByte installed successfully!"

