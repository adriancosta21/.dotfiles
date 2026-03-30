#!/usr/bin/env bash

# Official pacman packages
pacman_packages=(
  zsh
  kitty
  ttf-jetbrains-mono-nerd
  zoxide
  starship
  eza
  github-cli
  yay
  fastfetch
  cava
  hyprland
  hyprpolkitagent
  playerctl
  grim
  slurp
  wl-clipboard
  system-config-printer
  cups
  cups-filters
  cups-pk-helper
  ghostscript
  gsfonts
  thunar
  obsidian
  zen-browser-bin
)

# AUR packages
aur_packages=(
  dms-shell-bin
  dsearch-bin
  lsfg-vk-git
  spotify
)

echo "Installing official pacman packages..."
sudo pacman -S --needed "${pacman_packages[@]}"

echo "Installing AUR packages..."
yay -S --needed "${aur_packages[@]}"

echo "Instalation complete!"
