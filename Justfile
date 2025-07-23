alias b := brew
alias r := rebuild
alias u := update

brew:
    nix flake update homebrew-core homebrew-cask --flake .config/nix

rebuild:
    sudo darwin-rebuild switch --flake .config/nix#Main

update:
    nix flake update --flake .config/nix
