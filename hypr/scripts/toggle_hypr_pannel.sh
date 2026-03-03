if hyprpanel status >/dev/null 2>&1; then
  hyprpanel quit
else
  hyprpanel &
fi
