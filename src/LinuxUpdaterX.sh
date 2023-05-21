#!/bin/bash

# Define color variables
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Check if the script is executed by a user with administrative privileges
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}This script needs to be run with administrative privileges.${NC}" >&2
  exit 1
fi

# Updating the package list
echo -e "${GREEN}Updating the package list...${NC}"
apt-get update > /var/log/update_script.log 2>&1

# Checking for available updates
available_updates=$(apt-get -s upgrade | grep -P '^\d+ (upgraded|newly installed)')
if [[ -z $available_updates ]]; then
  echo -e "${YELLOW}No updates available.${NC}"
  exit 0
fi

# Updating the system
echo -e "${GREEN}Updating the system...${NC}"
apt-get upgrade -y >> /var/log/update_script.log 2>&1

echo -e "${GREEN}Update completed.${NC}"
