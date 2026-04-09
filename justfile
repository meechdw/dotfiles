default:
    just --list

brew_update:
    sudo nix flake update homebrew-core homebrew-cask --flake .config/nix

pack_uninstall_all:
    rm -rf ~/.local/share/nvim/site/pack/core/opt

nix_update:
    sudo nix flake update --flake .config/nix

rebuild:
    sudo darwin-rebuild switch --flake .config/nix#Main
