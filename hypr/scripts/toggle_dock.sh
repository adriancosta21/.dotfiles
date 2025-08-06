if pgrep -f "nwg-dock-hyprland" >/dev/null; then
  pkill nwg-dock-hyprland
else
  nwg-dock-hyprland &
fi
