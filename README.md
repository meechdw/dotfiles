# dotfiles

This repository contains my configuration files for macOS, managed with [nix-darwin](https://github.com/nix-darwin/nix-darwin) and [Home Manager](https://github.com/nix-community/home-manager).

## Bootstrap a New Machine

Install the Xcode Command Line Tools:

```bash
xcode-select --install
```

Give full disk access to the terminal: `System Settings` > `Privacy & Security` > `Full Disk Access`.

Ensure the following conditions are met before proceeding:

- If the system has not been rebooted since activation, reboot the system.
- If you have not yet logged into [GitHub](https://github.com) in the browser, do so now.

Then, run the bootstrap script:

```bash
curl -fsSL https://raw.githubusercontent.com/meechdw/dotfiles/main/bootstrap.sh | bash
```

Manually configure the following settings:

- Update desktop wallpaper: `System Settings` > `Wallpaper`.
- Shorten key repeat delay: `System Settings` > `Keyboard` > `Keyboard sensitivity`.
- Disable hotkey for Spotlight: `System Settings` > `Keyboard` > `Keyboard shortcuts` > `Spotlight`.

Run the `Import Preferences & Data` command in [Raycast](https://www.raycast.com) to import [Raycast.rayconfig](./Raycast.rayconfig).

Lastly, reboot the machine.

## Rebuild the Config

Changes to files other than [flake.nix](./.config/nix/flake.nix) do not require a rebuild since they are symlinked. Adding additional files or modifying [flake.nix](./.config/nix/flake.nix) requires a rebuild:

```bash
./rebuild.sh
```
