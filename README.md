# dotfiles

This repository contains my configuration files for macOS, managed with
[nix-darwin](https://github.com/nix-darwin/nix-darwin) and
[Home Manager](https://github.com/nix-community/home-manager).

## Bootstrap a New Machine

First, install the XCode Command Line Tools:

```bash
xcode-select --install
```

Install Rosetta:

```bash
softwareupdate --install-rosetta
```

Give full disk access to the terminal: `System Settings` >
`Privacy & Security` > `Full Disk Access`.

If the system has not been rebooted since activation, reboot the system. Then,
run the bootstrap script:

```bash
curl -fsSL https://raw.githubusercontent.com/meechdw/dotfiles/main/bootstrap.sh | bash
```

Give full disk access to the [WezTerm](https://wezterm.org): `System Settings` >
`Privacy & Security` > `Full Disk Access`.

Manually configure the following settings:

- Enable Night Shift: `System Settings` > `Displays` > `Night Shift`.
- Disable hotkey for Spotlight: `System Settings` > `Keyboard` >
  `Keyboard shortcuts` > `Spotlight`.
- Update desktop wallpaper: `System Settings` > `Wallpaper`.

Run the `Import Preferences & Data` command in
[Raycast](https://www.raycast.com) to import
[Raycast.rayconfig](./Raycast.rayconfig).

Run the
[Logitune](https://www.logitech.com/en-ca/video-collaboration/software/logi-tune-software.html)
application installer:

```bash
open /opt/homebrew/Caskroom/logitune/3.10.120/LogiTuneInstaller.app
```

Lastly, reboot the machine.
