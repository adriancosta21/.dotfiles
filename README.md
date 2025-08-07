# Intro
This system is designed to be used as a whole, cohesively.
## Tips
  * Vim motions
    * The vim motions can be used in the any terminal using the zsh, by pressing ESC or the jk binding. 
    > The jk binding must be pressed quickly. It's consistent across the zsh and nvim
## Required Packages
### For the terminal
  * Zsh
  * Starship
  * Eza
### For Hyprland
  * Multimedia
    * brightnessctl
    * playerctl
  * Quality of life
    * Hyprpaper
    * dunst 
    * xdg-desktop-portal-hyprland
    * wl-clipboard
    * slurp
    * grim
    * swayidle
    * Hyprlock
# Installation
1. Clone the repository
   ```bash
   git clone https://adriancosta21/.dotfiles.git ~/.dotfiles
   ```
2. Create symlinks to the ~/.config directory
   Links created:
    > * Zsh
    > * Kitty
    > * Nvim (LazyVim)
    > * Waybar
    > * FastFetch
    > * Hypr (Hyprland/ delete it, if not supported)

   ```bash
   ~/.dotfiles/makesymlinks.sh
   ```
3. Change terminal to zsh
   ```bash
   exec zsh
   chsh -s $(which zsh)
