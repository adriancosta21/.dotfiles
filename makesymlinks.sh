#!/usr/bin/env bash
# The .zshrc file must be located in the home directory
ln -s ~/.dotfiles/zsh/.zshrc ~/

# Other files will be transfered to ~/.config
folders=(nvim waybar fastfetch kitty hypr)
for item in "${folders[@]}"; do
  echo "Linking ~/.dotfiles/$item to ~/.config/$item"
  ln -s ~/.dotfiles/"$item" ~/.config/
done
