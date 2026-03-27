#!/bin/bash

# pega status floating da janela ativa
is_floating=$(hyprctl activewindow | awk -F": " '/floating:/ {print $2}')

# se já for floating → volta para tiled
if [[ "$is_floating" == "1" ]]; then
  hyprctl dispatch togglefloating
  exit 0
fi

# se não for floating → ativa floating, redimensiona e centraliza
hyprctl dispatch togglefloating
hyprctl dispatch resizeactive exact 1200 800
hyprctl dispatch centerwindow
