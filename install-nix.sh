#!/bin/bash

# Step 1: Install Nix package manager
echo "Installing Nix package manager..."
sh <(curl -L https://nixos.org/nix/install) --daemon

# Step 2: Add the Home Manager channel
echo "Adding Home Manager channel..."
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager

# Step 3: Update Nix channels
echo "Updating Nix channels..."
nix-channel --update

# Step 4: Install Home Manager using nix-shell
echo "Installing Home Manager..."
nix-shell '<home-manager>' -A install

# Step 5: Copy the contents of the current directory to ~/.config/home-manager
echo "Copying current directory contents to ~/.config/home-manager..."
mkdir -p ~/.config/home-manager
cp -r ./* ~/.config/home-manager/

# Final confirmation
echo "Home Manager installation complete and files copied to ~/.config/home-manager."
