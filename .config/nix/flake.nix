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
              pkgs.ngrok
              pkgs.neovim
              pkgs.raycast
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
                --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
                --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
                --color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
                --color=selected-bg:#494d64 \
                --color=border:#6e738d,label:#cad3f5
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
              { config, pkgs, ... }:
              {
                home.stateVersion = "25.05";

                programs.tmux = {
                  enable = true;
                  plugins = [
                    {
                      plugin = pkgs.tmuxPlugins.catppuccin;
                      extraConfig = ''
                        set -g @catppuccin_flavor "macchiato"
                        set -g @catppuccin_window_default_text " #W"
                        set -g @catppuccin_window_text " #W"
                        set -g @catppuccin_window_current_text " #W"
                        set -g @catppuccin_status_left_separator ""
                        set -g status-left ""
                      '';
                    }
                  ];
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
                    ".config/karabiner/karabiner.json".source =
                      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/karabiner/karabiner.json";
                    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/nvim";
                  };
              };
          };

          homebrew = {
            enable = true;
            brews = [
              "cloud-sql-proxy"
              "mas"
            ];
            casks = [
              "ghostty"
              "dbeaver-community"
              "discord"
              "firefox"
              "google-chrome"
              "gcloud-cli"
              "karabiner-elements"
              "libreoffice"
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
              };
            };
          }
        ];
      };
    };
}
