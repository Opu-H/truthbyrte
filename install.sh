#!/bin/bash

set -e

# Colors
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}Installing TruthByte...${NC}"

# Ensure bin and man dirs
sudo mkdir -p /usr/local/bin
sudo mkdir -p /usr/local/share/man/man1

# Copy script
sudo cp truthbyte.sh /usr/local/bin/truthbyte
sudo chmod +x /usr/local/bin/truthbyte

# Add 'tb' alias
echo 'alias tb=truthbyte' | sudo tee /etc/profile.d/truthbyte.sh > /dev/null
sudo chmod +x /etc/profile.d/truthbyte.sh

# Install man page
sudo cp man/truthbyte.1 /usr/local/share/man/man1/
sudo gzip -f /usr/local/share/man/man1/truthbyte.1

# Refresh man database
sudo mandb

echo -e "${GREEN}✅ TruthByte installed successfully!"
echo -e "You can now use it with 'truthbyte' or 'tb'${NC}"
