# Login into niri if there's no display on tty1
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    exec niri-session -l 
fi
