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
          nix.settings.experimental-features = "nix-command flakes";

          nixpkgs = {
            hostPlatform = "aarch64-darwin";
            config.allowUnfree = true;
          };

          environment = {
            systemPackages = [
              pkgs.awscli2
              pkgs.bat
              pkgs.bruno
              pkgs.claude-code
              pkgs.colima
              pkgs.dbeaver-bin
              pkgs.docker
              pkgs.doppler
              pkgs.exiftool
              pkgs.fastfetch
              pkgs.ffmpeg_6-full
              pkgs.fd
              pkgs.fzf
              pkgs.git
              pkgs.jira-cli-go
              pkgs.jq
              pkgs.just
              pkgs.lazydocker
              pkgs.lazygit
              pkgs.lftp
              pkgs.mkalias
              pkgs.neovim
              pkgs.nodejs_22
              pkgs.ollama
              pkgs.raycast
              pkgs.ripgrep
              pkgs.starship
              pkgs.tokei
              pkgs.vips
              pkgs.vim
              pkgs.wezterm
              pkgs.yarn
              pkgs.zoxide
            ];
            variables = {
              EDITOR = "nvim";
              DIRENV_WARN_TIMEOUT = "1m";
              GOPRIVATE = "bitbucket.org/wieckmedia/*";
              FZF_DEFAULT_OPTS = ''
                --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
                --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
                --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
                --color=selected-bg:#45475A \
                --color=border:#6C7086,label:#CDD6F4
              '';
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

          fonts.packages = [ pkgs.nerd-fonts.geist-mono ];

          system = {
            primaryUser = "mitchell";
            configurationRevision = self.rev or self.dirtyRev or null;
            stateVersion = 6;
            defaults = {
              dock.autohide = true;
              dock.show-recents = false;
              dock.persistent-apps = [
                "/Applications/Google Chrome.app"
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
                    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.zshrc";
                    ".config/bat".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/bat";
                    ".config/karabiner/karabiner.json".source =
                      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/karabiner/karabiner.json";
                    ".config/starship.toml".source =
                      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/starship.toml";
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
              "google-chrome"
              "karabiner-elements"
              "firefox"
              "logitune"
              "slack"
              "spotify"
              "visual-studio-code"
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
