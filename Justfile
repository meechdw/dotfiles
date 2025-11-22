alias b := brew_update
alias p := pack_uninstall_all
alias n := nix_update
alias r := rebuild

brew_update:
    sudo nix flake update homebrew-core homebrew-cask --flake .config/nix

pack_uninstall_all:
    rm ~/.config/nvim/nvim-pack-lock.json

nix_update:
    sudo nix flake update --flake .config/nix

rebuild:
    sudo darwin-rebuild switch --flake .config/nix#Main
