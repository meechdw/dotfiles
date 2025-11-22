{
  description = "Main system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    sst-homebrew-tap = {
      url = "github:sst/homebrew-tap";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nix-darwin,
      home-manager,
      neovim-nightly-overlay,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      sst-homebrew-tap,
      ...
    }:
    let
      configuration =
        { pkgs, config, ... }:
        {
          nix.enable = false;
          nix.settings.experimental-features = "nix-command flakes";

          nixpkgs = {
            hostPlatform = "aarch64-darwin";
            config.allowUnfree = true;
            overlays = [ neovim-nightly-overlay.overlays.default ];
          };

          environment = {
            systemPackages = [
              pkgs.awscli2
              pkgs.colima
              pkgs.docker
              pkgs.doppler
              pkgs.fastfetch
              pkgs.fd
              pkgs.fzf
              pkgs.git
              pkgs.jq
              pkgs.just
              pkgs.lazygit
              pkgs.neovim
              pkgs.raycast
              pkgs.ripgrep
              pkgs.starship
              pkgs.tokei
              pkgs.vim
              pkgs.wezterm
              pkgs.zoxide
            ];
            variables = {
              EDITOR = "nvim";
              DIRENV_WARN_TIMEOUT = "1m";
              FZF_DEFAULT_OPTS = ''
                --color=bg+:#45403d,bg:#282828,spinner:#d3869b,hl:#a9b665 \
                --color=fg:#d4be98,header:#ea6962,info:#d8a657,pointer:#ea6962 \
                --color=marker:#a9b665,fg+:#ddc7a1,prompt:#7daea3,hl+:#a9b665 \
                --color=selected-bg:#3c3836 \
                --color=border:#928374,label:#d4be98
              '';
              ZVM_VI_HIGHLIGHT_BACKGROUND = "#45403d";
              ZVM_VI_HIGHLIGHT_FOREGROUND = "#d4be98";
            };
            extraInit = ''
              export PATH="$HOME/.local/bin:$PATH"
              export PATH="$HOME/src/dotfiles/bin:$PATH"
            '';
          };

          power.sleep.display = 10;

          programs.direnv.enable = true;

          fonts.packages = [ pkgs.nerd-fonts.blex-mono ];

          system = {
            primaryUser = "mitchell";
            configurationRevision = self.rev or self.dirtyRev or null;
            stateVersion = 6;
            keyboard = {
              enableKeyMapping = true;
              remapCapsLockToControl = true;
            };
            defaults = {
              dock.autohide = true;
              dock.show-recents = false;
              dock.persistent-apps = [
                "/Applications/Nix Apps/WezTerm.app"
                "/Applications/Google Chrome.app"
                "/System/Applications/Mail.app"
                "/System/Applications/Calendar.app"
                "/System/Applications/Notes.app"
              ];
              loginwindow.GuestEnabled = false;
              NSGlobalDomain = {
                AppleInterfaceStyle = "Dark";
                KeyRepeat = 2;
                InitialKeyRepeat = 15;
                NSAutomaticSpellingCorrectionEnabled = false;
              };
              universalaccess.reduceMotion = true;
            };
          };

          imports = [ home-manager.darwinModules.home-manager ];

          users.users.mitchell.home = "/Users/mitchell";

          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.mitchell =
              { config, ... }:
              {
                home.stateVersion = "25.05";
                home.file =
                  let
                    dotfiles = "${config.home.homeDirectory}/src/dotfiles";
                  in
                  {
                    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.zshrc";
                    ".config/starship.toml".source =
                      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/starship.toml";
                    ".config/karabiner/karabiner.json".source =
                      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/karabiner/karabiner.json";
                    ".config/opencode".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/opencode";
                    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/nvim";
                    ".config/wezterm".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/wezterm";
                  };
              };
          };

          homebrew = {
            enable = true;
            brews = [
              "mas"
              "sst/homebrew-tap/opencode"
            ];
            casks = [
              "discord"
              "firefox"
              "google-chrome"
              "karabiner-elements"
              "logitune"
              "spotify"
            ];
            onActivation = {
              cleanup = "zap";
              autoUpdate = true;
              upgrade = true;
            };
            taps = builtins.attrNames config.nix-homebrew.taps;
          };
        };
    in
    {
      darwinConfigurations."Main" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "mitchell";
              mutableTaps = false;
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
                "sst/homebrew-tap" = sst-homebrew-tap;
              };
            };
          }
        ];
      };
    };
}
