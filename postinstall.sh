#!/bin/bash

# Path to the desired zsh shell
ZSH_PATH="/home/unknown/.nix-profile/bin/zsh"

# Check if the zsh path is already in /etc/shells
if ! grep -Fxq "$ZSH_PATH" /etc/shells; then
  echo "Adding $ZSH_PATH to /etc/shells"
  # Add the path to /etc/shells if it doesn't already exist
  echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null
else
  echo "$ZSH_PATH is already in /etc/shells"
fi

# Change the default shell to zsh
echo "Setting $ZSH_PATH as the default shell"
chsh -s "$ZSH_PATH"

# Confirm the change
echo "Default shell set to: $(echo $SHELL)"
