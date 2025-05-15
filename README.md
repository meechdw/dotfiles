# dotfiles

This repository contains my configuration files for macOS, managed with [nix-darwin](https://github.com/nix-darwin/nix-darwin) and [Home Manager](https://github.com/nix-community/home-manager).

## Bootstrap a New Machine

First, install the XCode Command Line Tools:

```bash
xcode-select --install
```

Give full disk access to the terminal: `System Settings` > `Privacy & Security` > `Full Disk Access`.

If the system has not been rebooted since activation, reboot the system. Then, run the bootstrap script:

```bash
curl -fsSL https://raw.githubusercontent.com/meechdw/dotfiles/main/bootstrap.sh | bash
```

Give full disk access to the WezTerm: `System Settings` > `Privacy & Security` > `Full Disk Access`.

Manually configure the following settings:

- Shorten key repeat delay: `System Settings` > `Keyboard` > `Keyboard sensitivity`.
- Update desktop wallpaper: `System Settings` > `Wallpaper`.
- Configure display sleep durations: `System Settings` > `Lock Screen`.
- Enable Night Shift: `System Settings` > `Displays` > `Night Shift`.
- Disable hotkey for Spotlight: `System Settings` > `Keyboard` > `Keyboard shortcuts` > `Spotlight`.

Run the `Import Preferences & Data` command in [Raycast](https://www.raycast.com) to import [Raycast.rayconfig](./Raycast.rayconfig).

Lastly, reboot the machine.

## Rebuild the Config

Changes to files other than [flake.nix](./.config/nix/flake.nix) do not require a rebuild since they are symlinked. Adding additional files, removing existing files, or modifying [flake.nix](./.config/nix/flake.nix) requires a rebuild:

```bash
./rebuild.sh
```
