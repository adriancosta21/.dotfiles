#!/bin/bash

# Conta janelas na workspace atual
WINDOW_COUNT=$(hyprctl clients -j | jq '[.[] | select(.workspace.id == (hyprctl activeworkspace -j | jq .id))] | length')

# Verifica se waybar está rodando
if pgrep -x "waybar" >/dev/null; then
  WAYBAR_RUNNING=true
else
  WAYBAR_RUNNING=false
fi

# Se só há uma janela e waybar não está rodando, ativa fullscreen
if [ "$WINDOW_COUNT" -eq 1 ] && [ "$WAYBAR_RUNNING" = false ]; then
  hyprctl dispatch fullscreen 1
fi
