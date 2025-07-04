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
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nix-darwin,
      home-manager,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      ...
    }:
    let
      configuration =
        { pkgs, config, ... }:
        {
          nix.settings.experimental-features = "nix-command flakes";

          nixpkgs = {
            hostPlatform = "aarch64-darwin";
            config.allowUnfree = true;
          };

          environment = {
            systemPackages = [
              pkgs.aider-chat-full
              pkgs.awscli2
              pkgs.bat
              pkgs.bruno
              pkgs.colima
              pkgs.dbeaver-bin
              pkgs.docker
              pkgs.doppler
              pkgs.eza
              pkgs.fastfetch
              pkgs.fd
              pkgs.fzf
              pkgs.git
              pkgs.lazygit
              pkgs.lftp
              pkgs.mkalias
              pkgs.neovim
              pkgs.nodejs_22
              pkgs.raycast
              pkgs.ripgrep
              pkgs.starship
              pkgs.tokei
              pkgs.wezterm
              pkgs.yarn
              pkgs.zoxide
            ];
            variables = {
              EDITOR = "nvim";
              DIRENV_WARN_TIMEOUT = "1m";
              GOPRIVATE = "bitbucket.org/wieckmedia/*";
              EZA_CONFIG_DIR = "$HOME/.config/eza";
            };
            extraInit = ''
              export PATH="$HOME/.local/bin:$PATH"
              export PATH="$HOME/src/dev-tools/bin:$PATH"
              export PATH="$HOME/src/dotfiles/bin:$PATH"
              export PATH="$HOME/src/infrastructure/bin:$PATH"
            '';
          };

          power.sleep.display = 10;

          programs.direnv.enable = true;

          fonts.packages = [ pkgs.nerd-fonts.blex-mono ];

          system = {
            primaryUser = "mitchell";
            configurationRevision = self.rev or self.dirtyRev or null;
            stateVersion = 6;
            defaults = {
              dock.autohide = true;
              dock.show-recents = false;
              dock.persistent-apps = [
                "/Applications/Firefox.app"
                "${pkgs.wezterm}/Applications/WezTerm.app"
                "/Applications/Slack.app"
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
                    ".aider.conf.yml".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.aider.conf.yml";
                    ".aider.model.setting.yml".source =
                      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.aider.model.setting.yml";
                    ".wezterm.lua".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.wezterm.lua";
                    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.zshrc";
                    ".config/starship.toml".source =
                      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/starship.toml";
                    ".config/karabiner/karabiner.json".source =
                      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/karabiner/karabiner.json";
                    ".config/bat".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/bat";
                    ".config/eza".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/eza";
                    ".config/git".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/git";
                    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/nvim";
                    ".config/wezterm".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/wezterm";
                  };
              };
          };

          homebrew = {
            enable = true;
            brews = [
              "mas"
            ];
            casks = [
              "cursor"
              "discord"
              "google-chrome"
              "karabiner-elements"
              "firefox"
              "slack"
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
              };
            };
          }
        ];
      };
    };
}
