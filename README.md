# Dotfiles

These dotfiles are designed to be used as a complete system configuration rather than a collection of independent files.

The repository contains my personal Arch Linux setup, including shell, terminal, editor, desktop environment, system services, and various application configurations. Most of the configuration is actively maintained and intended to work together.

> **Warning**
>
> This repository is extremely tailored to my personal Arch Linux installation. The installation script makes system-wide changes, installs packages, enables services, and creates symlinks in your home directory. Review the script before running it and do not expect it to work as a generic Arch installer.

## Setup overview

| Component                          | Software                  |
| ---------------------------------- | ------------------------- |
| Compositor                         | Niri                      |
| Bar / Notifications / App launcher | DMS (Dank Material Shell) |
| Shell                              | Zsh                       |
| Shell prompt                       | Starship                  |
| Terminal Emulator                  | Kitty                     |
| Terminal Multiplexer               | Tmux                      |
| Code editor                        | Neovim                    |

## Usage

### Manual

Clone the repository and create symlinks using GNU Stow.

```bash
git clone https://github.com/adriancosta21/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow <package>
```

Each directory can be installed independently.

### Installation script

> [!WARNING]
> `install.sh` is intended for **my personal setup**, not as a generic installer.
>
> It will:
>
> * Install official packages with `pacman`.
> * Install AUR packages using `yay`.
> * Enable and start systemd services.
> * Create symlinks with GNU Stow.
> * Modify your system to match my configuration.
>
> Review the script before running it.

```bash
chmod +x ./install.sh
./install.sh
```

The installer writes diagnostic messages to `~/dotfiles.log`.

#### Requirements

* Arch Linux or an Arch-based distribution.
* Internet connection.
* Yay AUR helper (will be compiled, if needed)
* Systemd


## Repository structure

Most directories contain active configurations used by the installation script.

## Requirements (manual install)

### Shell

The shell configuration is built around **Zsh** and includes utilities for navigation, prompt customization, file listing, and terminal customization.

Required packages:

```text
zsh
zoxide
starship
bat
eza
ttf-jetbrains-mono-nerd
```

> **Note**
>
> This repository separates some configurations into independent Stow packages. For the best experience, it is recommended to also stow the `starship` and `tmux` packages after configuring Zsh.
>
> ```bash
> stow starship
> stow tmux
> ```

> **Note**
>
> Zsh uses Vim keybindings by default in this configuration. You can switch between insert mode and normal mode using `ESC`, or use `jk` as an alternative keybinding to leave insert mode.

To check your current shell:

```bash
echo $SHELL
```

If your shell is not Zsh, change it with:

```bash
# Run if your current shell is not zsh
exec zsh
chsh -s $(which zsh)
```

A reboot or a new login session may be required for the change to take effect.
### Kitty

The Kitty configuration provides terminal emulator settings, including appearance, font configuration, and keybindings.

Required packages:

```text
kitty
ttf-jetbrains-mono-nerd
```

### Neovim

The Neovim configuration relies on external command-line tools for searching and file navigation.

Required packages:

```text
fd
fzf
```

### Niri

The Niri configuration provides the compositor setup and related desktop environment customization.

Required packages:

```text
niri
xwayland-satellite
dms-shell-niri (AUR)
cava
playerctl
xdg-desktop-portal
wl-clipboard
```

Optional packages:

```text
dsearch-bin (AUR)
```

> **Note**
>
> If you install `dsearch-bin`, you also need to stow the `danksearch` package to enable its configuration.
>
> ```bash
> stow danksearch
> ```

## Legacy

The following configurations are no longer maintained and are not used by the current setup or the installation script. They are kept for reference and for anyone who still wishes to stow them manually.

* `hyprland`

## License

Feel free to explore, adapt, and reuse any part of this repository.
