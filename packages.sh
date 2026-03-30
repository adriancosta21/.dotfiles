#!/usr/bin/env bash

# Official pacman packages
pacman_packages=(
  zsh
  kitty
  ttf-jetbrains-mono-nerd
  zoxide
  starship
  yay
  fastfetch
  cava
  thunar
  playerctl
  grim
  slurp
  wl-clipboard
  hyprland
  hyprpolkitagent
  system-config-printer
  cups
  cups-filters
  cups-pk-helper
  ghostscript
  gsfonts
  github-cli
  obsidian
  stow
  eza
  zen-browser-bin
)

# AUR packages
aur_packages=(
  dms-shell-bin
  lsfg-vk-git
  spotify
)

echo "Installing official pacman packages..."
sudo pacman -S --needed "${pacman_packages[@]}"

echo "Installing AUR packages..."
yay -S --needed "${aur_packages[@]}"

echo "Instalation complete!"
