#!/bin/bash

is_floating=$(niri msg --json focused-window | jq -r '.is_floating')

if [[ "$is_floating" == "true" ]]; then
  # volta para tiled primeiro
  niri msg action toggle-window-floating

  # conta quantas janelas tiled existem na mesma workspace
  workspace_id=$(niri msg --json focused-window | jq -r '.workspace_id')
  window_count=$(niri msg --json windows | jq --argjson wsid "$workspace_id" \
    '[.[] | select(.workspace_id == $wsid and .is_floating == false)] | length')

  if [[ "$window_count" -le 1 ]]; then
    niri msg action set-column-width "100%"
  else
    niri msg action set-column-width "50%"
  fi
  exit 0
fi

# ativa floating, redimensiona e centraliza
niri msg action toggle-window-floating
niri msg action set-window-width 1200
niri msg action set-window-height 800
niri msg action center-window
