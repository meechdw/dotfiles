#!/usr/bin/env bash

set -e

mkdir -p ~/src
cd ~/src

softwareupdate --install-rosetta

sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)

git clone https://github.com/meechdw/dotfiles.git
cd dotfiles
git remote set-url origin git@github.com:meechdw/dotfiles.git

. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'

nix run nix-darwin/master#darwin-rebuild --extra-experimental-features 'nix-command flakes' --impure -- switch --flake ./.config/nix#Main

/run/current-system/sw/bin/doppler login

ANTHROPIC_API_KEY=$(/run/current-system/sw/bin/doppler secrets get --project personal --plain ANTHROPIC_API_KEY)
security add-generic-password -a "$USER" -s "ENV_ANTHROPIC_API_KEY" -w "$ANTHROPIC_API_KEY"

DEEPSEEK_API_KEY=$(/run/current-system/sw/bin/doppler secrets get --project personal --plain DEEPSEEK_API_KEY)
security add-generic-password -a "$USER" -s "ENV_DEEPSEEK_API_KEY" -w "$DEEPSEEK_API_KEY"

AWS_ACCESS_KEY_ID=$(/run/current-system/sw/bin/doppler secrets get --project personal --plain AWS_ACCESS_KEY_ID)
AWS_SECRET_ACCESS_KEY=$(/run/current-system/sw/bin/doppler secrets get --project personal --plain AWS_SECRET_ACCESS_KEY)

mkdir -p ~/.aws

cat > ~/.aws/credentials <<EOF
[default]
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
EOF

curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/mac_arm64/session-manager-plugin.pkg" -o "session-manager-plugin.pkg"
sudo installer -pkg session-manager-plugin.pkg -target /
sudo ln -s /usr/local/sessionmanagerplugin/bin/session-manager-plugin /usr/local/bin/session-manager-plugin

mkdir -p ~/.local/bin
mv session-manager-plugin.pkg ~/.local/bin/

mkdir -p ~/.ssh
chmod 700 ~/.ssh

GIT_SSH_PRIVATE_KEY=$(/run/current-system/sw/bin/doppler secrets get --project personal --plain GIT_SSH_PRIVATE_KEY)
cat > ~/.ssh/id_ed25519 <<< "$GIT_SSH_PRIVATE_KEY"
chmod 600 ~/.ssh/id_ed25519

GIT_SSH_PUBLIC_KEY=$(/run/current-system/sw/bin/doppler secrets get --project personal --plain GIT_SSH_PUBLIC_KEY)
cat > ~/.ssh/id_ed25519.pub <<< "$GIT_SSH_PUBLIC_KEY"
chmod 644 ~/.ssh/id_ed25519.pub

eval "$(ssh-agent -s)"

cat >> ~/.ssh/config <<EOF
Host github.com
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519
EOF

ssh-add ~/.ssh/id_ed25519

git config --global user.name "Mitchell Wilson"
git config --global user.email "mitchelldw01@gmail.com"

echo -e "\nBootstrap complete. Reboot your system."

cd ~
