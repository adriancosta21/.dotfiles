# XDG compliant directory locations
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state/"
export XDG_DATA_DIRS=${XDG_DATA_DIRS:-/usr/local/share:/usr/share}:/var/lib/snapd/desktop

# Prefer Wayland with fallback support (Qt + Chromium/Electron)
export OZONE_PLATFORM=auto
export QT_QPA_PLATFORM="wayland;xcb" 

# Android Development (SDK paths)
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$HOME/.local/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH"

# Others
export STARSHIP_CONFIG=~/.config/starship/starship.toml

