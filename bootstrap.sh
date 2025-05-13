#!/usr/bin/env bash

ssh-keygen -t ed25519 -C "mitchelldw01@gmail.com"

eval "$(ssh-agent -s)"

echo "Host github.com\n  AddKeysToAgent yes\n  IdentityFile ~/.ssh/id_ed25519" >> ~/.ssh/config

ssh-add ~/.ssh/id_ed25519

pbcopy < ~/.ssh/id_ed25519.pub

echo "SSH key copied to clipboard. Please add it to your GitHub account."
echo "Press ENTER to open the GitHub SSH key settings page..."

read -r
open "https://github.com/settings/keys"

git config --global user.name "Mitchell Wilson"
git config --global user.email "mitchelldw01@gmail.com"

mkdir -p ~/src
cd ~/src

git clone git@github.com:meechdw/dotfiles.git
cd dotfiles

softwareupdate --install-rosetta

sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)

. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'

nix run nix-darwin/master#darwin-rebuild --extra-experimental-features 'nix-command flakes' --impure -- switch --flake ./.config/nix#Main

echo -e "\nBootstrap complete. Please reboot your system."

cd ~
