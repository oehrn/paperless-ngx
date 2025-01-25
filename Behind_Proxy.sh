#!/bin/bash

# Check if the user is root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Prompt the user for the LXC container ID
read -p "Enter the LXC container ID for Paperless: " CONTAINER_ID

# Prompt the user for the URL
read -p "Enter the URL for Paperless (format: https://example.com): " PAPERLESS_URL

# Validate the URL format
if [[ ! $PAPERLESS_URL =~ ^https?://[a-zA-Z0-9.-]+$ ]]; then
  echo "Invalid URL format. Please use the format: https://example.com"
  exit 1
fi

# Use 'find' to locate the paperless.conf file inside the container
CONFIG_PATH=$(lxc-attach -n "$CONTAINER_ID" -- find / -name "paperless.conf" 2>/dev/null)

# Check if the file was found
if [ -z "$CONFIG_PATH" ]; then
  echo "Configuration file 'paperless.conf' not found in the container."
  exit 1
fi

# Check if the parameter already exists
EXISTING_PARAM=$(lxc-attach -n "$CONTAINER_ID" -- grep -E "^PAPERLESS_URL=" "$CONFIG_PATH")
if [ -n "$EXISTING_PARAM" ]; then
  # Update the existing parameter
  lxc-attach -n "$CONTAINER_ID" -- sed -i "s|^PAPERLESS_URL=.*|PAPERLESS_URL=$PAPERLESS_URL|" "$CONFIG_PATH"
  echo "Updated existing PAPERLESS_URL parameter in $CONFIG_PATH."
else
  # Add the parameter if it does not exist
  lxc-attach -n "$CONTAINER_ID" -- bash -c "echo 'PAPERLESS_URL=$PAPERLESS_URL' >> $CONFIG_PATH"
  echo "Added PAPERLESS_URL parameter to $CONFIG_PATH."
fi

# Restart the container to apply changes
read -p "Do you want to restart the container now? (y/n): " RESTART
if [[ $RESTART == "y" || $RESTART == "Y" ]]; then
  lxc-stop -n "$CONTAINER_ID" && lxc-start -n "$CONTAINER_ID"
  echo "Container $CONTAINER_ID restarted successfully."
else
  echo "Restart skipped. Please restart the container manually to apply changes."
fi

exit 0
