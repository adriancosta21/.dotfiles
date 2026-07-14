#!/usr/bin/env bash

# === VARIABLES ===

DOTFILES_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"

# Official pacman packages
PACMAN_PKG=(
  # Shell
  zsh
  kitty
  neovim
  zoxide
  starship
  eza
  # Fonts
  ttf-jetbrains-mono-nerd # kitty font / default system font
  noto-fonts              # special characters
  noto-fonts-emoji        # emojis
  noto-fonts-cjk          # chinese, japanese, korean characters
  # System
  niri
  xwayland-satellite
  dms-shell-niri
  cava
  playerctl
  xdg-desktop-portal
  wl-clipboard
  # Audio
  pipewire
  wireplumber
  pipewire-pulse
  pipewire-alsa
  alsa-utils
  sof-firmware
  # Bluetooth
  bluez
  bluez-utils
  # Video
  vlc
  # Printers
  system-config-printer
  cups
  cups-filters
  nss-mdns
  cups-pk-helper
  ghostscript
  gsfonts
  # CLI Tools
  bat
  btop
  fastfetch
  fd
  fzf
  github-cli
  tmux
  # Internet connection
  iwd
  dhcpcd
  # Apps
  dolphin
  okular
  obsidian
)

# Will be installed with yay AUR helper
AUR_PKG=(
  dsearch-bin
  onlyoffice-bin
  spotify
  zen-browser-bin
)

# Symlinks that will be created using GNU stow
STOW_PKG=(
  zsh
  starship
  tmux
  fastfetch
  kitty
  niri
  danksearch
)

# === SETUP ===

LOGFILE="$HOME/dotfiles.log"

# Cleans up (or create) LOGFILE
: >$LOGFILE

# Send every stderr to LOFILE
exec 2>>"$LOGFILE"

# === FUNCTIONS ===

warning_prompt() {
  cat <<'EOF'
===========================================
            WARNING
===========================================

This installer is highly opinionated and
tailored to a specific Arch Linux setup.

It will:
  • Install and remove packages
  • Enable and start systemd services
  • Create symlinks in your HOME directory
  • Overwrite existing dotfiles when using stow -R

Do NOT run this script unless you understand
what it does and have reviewed its contents.

Continue? [y/N]
EOF

  read -r answer

  case "$answer" in
  [Yy])
    echo "Starting installation..."
    ;;
  *)
    echo "Installation aborted."
    exit 0
    ;;
  esac
}

check_arch() {
  if ! command -v pacman &>/dev/null; then
    echo "This install script must be used inside arch-based systems"
    exit 1
  fi
}
check_internet() {
  echo "Checking internet connection..."
  if ! ping -c1 -W3 archlinux.org &>/dev/null; then
    echo "No internet connection"
    exit 1
  fi

}
compile_yay() {
  echo "yay not installed. Compiling yay from source..."
  sudo pacman -S --needed --noconfirm base-devel git &>/dev/null

  local tmpdir
  tmpdir=$(mktemp -d)
  if git clone https://aur.archlinux.org/yay.git "$tmpdir/yay" &&
    (cd $tmpdir && makepkg -si --noconfirm); then
    echo "Yay installed successfully"
  else
    echo "Error while compiling yay"
    exit 1
  fi
  rm -rf $tmpdir
}

pacman_packages() {
  echo "Installing official pacman packages..."
  if sudo pacman -S --needed --noconfirm "${PACMAN_PKG[@]}"; then
    echo "Pacman packages installed successfully"
  else
    echo "Error while downloading pacman packages"
    exit 1
  fi
}

aur_packages() {
  echo "Installing AUR packages using yay helper..."
  if ! command -v yay; then
    compile_yay
  fi
  if yay -S --needed --noconfirm "${AUR_PKG[@]}"; then
    echo "Instalation complete!"
  else
    echo "Error while downloading AUR packages"
    exit 1
  fi
}
stow_dotfiles() {
  echo "Creating symlinks for .dotfiles"
  for pkg in "${STOW_PKG[@]}"; do
    if ! stow -R --target="$HOME" "$pkg"; then
      echo "error while creating symlink with GNU stow for package: $pkg. Config file  probably already exists"
    fi
  done
}
systemd_setup() {
  echo "Setting up systemd services..."
  services=(bluetooth cups avahi-daemon)
  if sudo systemctl enable --now "${services[@]}" && systemctl --user enable dsearch; then
    echo "Systemd services enabled correctly"
  else
    echo "Error while setting up systemd services"
    exit 1
  fi
}

# === CODE EXECUTION ===

warning_prompt
check_arch
check_internet
pacman_packages
aur_packages
stow_dotfiles
systemd_setup
echo "Instalation complete! Check ~/dotfiles.log for warnings or errors"
exit 0
