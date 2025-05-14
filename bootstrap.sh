#!/usr/bin/env bash

xcode-select --install

mkdir -p ~/src
cd ~/src

git clone https://github.com/meechdw/dotfiles.git
cd dotfiles

softwareupdate --install-rosetta

sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)

. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'

nix run nix-darwin/master#darwin-rebuild --extra-experimental-features 'nix-command flakes' --impure -- switch --flake ./.config/nix#Main

doppler login

mkdir -p ~/.ssh
chmod 700 ~/.ssh

GIT_SSH_PRIVATE_KEY=$(doppler secrets get --project personal --plain GIT_SSH_PRIVATE_KEY)
cat > ~/.ssh/id_ed25519 <<< "$GIT_SSH_PRIVATE_KEY"
chmod 600 ~/.ssh/id_ed25519

GIT_SSH_PUBLIC_KEY=$(doppler secrets get --project personal --plain GIT_SSH_PUBLIC_KEY)
cat > ~/.ssh/id_ed25519.pub <<< "$GIT_SSH_PUBLIC_KEY"
chmod 644 ~/.ssh/id_ed25519.pub

eval "$(ssh-agent -s)"
echo -e "Host github.com\n  AddKeysToAgent yes\n  IdentityFile ~/.ssh/id_ed25519" >> ~/.ssh/config
ssh-add ~/.ssh/id_ed25519

git config --global user.name "Mitchell Wilson"
git config --global user.email "mitchelldw01@gmail.com"

ANTHROPIC_API_KEY=$(doppler secrets get --project personal --plain ANTHROPIC_API_KEY)
security add-generic-password -a "$USER" -s "ENV_ANTHROPIC_API_KEY" -w "$ANTHROPIC_API_KEY"

echo -e "\nBootstrap complete. Reboot your system."

cd ~
