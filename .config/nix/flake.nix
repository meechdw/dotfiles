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
              pkgs.claude-code
              pkgs.colima
              pkgs.docker
              pkgs.doppler
              pkgs.fastfetch
              pkgs.fd
              pkgs.fzf
              pkgs.gh
              pkgs.git
              pkgs.git-lfs
              pkgs.jq
              pkgs.lazygit
              pkgs.neovim
              pkgs.ripgrep
              pkgs.sesh
              pkgs.starship
              pkgs.tokei
              pkgs.tree-sitter
              pkgs.vim
              pkgs.zoxide
            ];
            variables = {
              EDITOR = "nvim";
              DIRENV_WARN_TIMEOUT = "1m";
              FZF_DEFAULT_OPTS = ''
                --color=bg+:#414b50,bg:#272e33,spinner:#a7c080,hl:#e67e80 \
                --color=fg:#d3c6aa,header:#e67e80,info:#d699b6,pointer:#a7c080 \
                --color=marker:#a7c080,fg+:#d3c6aa,prompt:#d699b6,hl+:#e67e80 \
                --color=selected-bg:#4c3743 \
                --color=border:#859289,label:#d3c6aa
              '';
              ZVM_VI_HIGHLIGHT_BACKGROUND = "#4c3743";
              ZVM_VI_HIGHLIGHT_FOREGROUND = "#d3c6aa";
            };
            extraInit = ''
              export PATH="$HOME/.local/bin:$PATH"
              export PATH="$HOME/src/dotfiles/bin:$PATH"
            '';
          };

          power.sleep.display = 10;

          programs.direnv.enable = true;

          fonts.packages = [ pkgs.nerd-fonts.geist-mono ];

          system = {
            primaryUser = "mitchell";
            configurationRevision = self.rev or self.dirtyRev or null;
            stateVersion = 6;
            keyboard =
              let
                rightCmd = 30064771303;
                rightCtrl = 30064771300;
              in
              {
                enableKeyMapping = true;
                remapCapsLockToEscape = true;
                userKeyMapping = [
                  {
                    HIDKeyboardModifierMappingSrc = rightCmd;
                    HIDKeyboardModifierMappingDst = rightCtrl;
                  }
                ];
              };
            defaults = {
              dock.autohide = true;
              dock.show-recents = false;
              dock.persistent-apps = [
                "/Applications/Ghostty.app"
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

                programs.tmux = {
                  enable = true;
                  extraConfig = ''
                    set -g prefix C-Space
                    unbind C-b
                    bind C-Space send-prefix
                    set -g default-terminal "tmux-256color"
                    set -ag terminal-overrides ",xterm-256color:RGB"
                    set -g status-position top
                    set -g renumber-windows on
                    set -g automatic-rename on
                    set -g mouse on
                    set -s copy-command "pbcopy"
                    bind-key x kill-pane
                    set -g detach-on-destroy off
                    bind-key "T" run-shell "sesh connect \"$(
                      sesh list --icons | fzf-tmux -p 80%,70% \
                        --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
                        --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
                        --bind 'tab:down,btab:up' \
                        --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
                        --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
                        --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
                        --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
                        --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
                        --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
                        --preview-window 'right:55%' \
                        --preview 'sesh preview {}'
                    )\""
                    bind -N "last-session (via sesh) " L run-shell "sesh last"
                    bind w display-popup -E "tmux list-windows -F '#{window_index}: #{window_name}' | fzf | awk '{print \$1}' | tr -d ':' | xargs tmux select-window -t"

                    set -g status-style "bg=#2e383c,fg=#d3c6aa"
                    set -g status-left-length 40
                    set -g status-right-length 80
                    set -g status-left "#[bg=#a7c080,fg=#272e33,bold] #S "
                    set -g status-right "#[fg=#859289]%Y-%m-%d %H:%M #[bg=#7fbbb3,fg=#272e33,bold] #(whoami) "
                    set -g window-status-format "#[bg=#2e383c,fg=#859289] #I:#W "
                    set -g window-status-current-format "#[bg=#414b50,fg=#9da9a0,bold] #I:#W "
                    set -g window-status-separator ""
                    set -g pane-border-style "fg=#414b50"
                    set -g pane-active-border-style "fg=#a7c080"
                    set -g message-style "bg=#414b50,fg=#d3c6aa"
                    set -g mode-style "bg=#4c3743,fg=#d3c6aa"
                  '';
                };

                home.file =
                  let
                    dotfiles = "${config.home.homeDirectory}/src/dotfiles";
                  in
                  {
                    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.zshrc";
                    ".config/ghostty".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/ghostty";
                    ".config/git".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/git";
                    ".config/starship.toml".source =
                      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/starship.toml";
                    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/nvim";
                  };
              };
          };

          homebrew = {
            enable = true;
            brews = [
              "mas"
            ];
            casks = [
              "ghostty"
              "dbeaver-community"
              "discord"
              "firefox"
              "google-chrome"
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
