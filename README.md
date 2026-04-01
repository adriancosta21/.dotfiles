# Intro
This system is designed to be used as a whole, cohesively.

## Current config
  * Compositor: Hyprland
  * Bar/Notifications/App launcher: DMS (Dank Material Shell)
  * Shell: ZSH
  * Shell prompt: Starship
  * Terminal Emulator: Kitty
  * Terminal Multiplexer: Tmux
  * Code editor: Neovim

## Tips
  * Vim motions
    * The vim motions can be used in any terminal using the zsh, by pressing ESC or the jk binding. 
    > The jk binding must be pressed quickly. It's consistent across the zsh and nvim

# Installed Packages
## For the terminal
  * zsh
  * zoxide
  * starship
  * eza  
  * kitty
  * ttf-jetbrains-mono-nerd
  * github-cli
  * fastfetch
  * yay
## For Hyprland
  * hyprland
  * hyprpolkitagent 
  * wl-clipboard
  * slurp
  * grim
## For DMS
  * dms-shell-bin
  * dsearch-bin
  * cava
## Printing support
  * system-config-printer
  * cups
  * cups-filters
  * cups-pk-helper
  * ghostscript
  * gsfonts
## Apps
  * Thunar
  * Spotify
  * Obsidian
  * Zen Browser
# Installation
1. Clone the repository and create symlinks (requires GNU stow)
   ```bash
    git clone https://github.com/adriancosta21/.dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    stow */
   ```
2. Install packages (Pacman + AUR)
   ```bash
    chmod +x ./packages.sh
    ./packages.sh
   ```
3. Change terminal shell to Zsh
   ```bash
   exec zsh
   chsh -s $(which zsh)
   ```
