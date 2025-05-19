#!/usr/bin/env bash

set -euo pipefail

log() {
  echo -e "\033[1;32m==>\033[0m $*"
}

error() {
  echo -e "\033[1;31m[ERROR]\033[0m $*" >&2
  exit 1
}

if [[ "$EUID" -eq 0 ]]; then
  error "Please do not run as root. Use a normal user with sudo privileges."
fi

log "Installing yay AUR helper"
cd /tmp
if ! command -v yay >/dev/null 2>&1; then
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
else
  log "yay already installed"
fi
cd "$HOME"

log "Installing packages with yay"
yay -S --needed --noconfirm \
  git-delta fish github-cli stow bat fzf erdtree eza starship tealdeer helix \
  xh yazi zellij glow wezterm visual-studio-code-bin firefox unzip \
  catppuccin-cursors-mocha papirus-folders-catppuccin-git \
  noto-fonts-emoji adwaita-fonts \
  kubectl kubectx kubeseal helm k9s

log "Installing Rust with rustup"
if ! command -v rustup >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
else
  log "Rust already installed"
fi
  
log "Installing FNM"
if [ ! -d "$HOME/.fnm" ]; then
  curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "$HOME/.fnm" --skip-shell
else
  log "FNM already installed"
fi

DOTFILES_REPO="git@github.com:JorgeMayoral/AetherForge.git"
DOTFILES_DIR="$HOME/AetherForge"
if [ ! -d "$DOTFILES_DIR" ]; then
  log "Cloning dotfiles"
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
  log "Dotfiles already cloned"
fi
log "Stowing dotfiles"
CONFIG_DIR="$HOME/.config"
cd "$DOTFILES_DIR/dotfiles"

FOLDERS=("bat" "bottom" "fish" "helix" "k9s" "nushell" "wezterm" "yazi" "zellij")
FLAT_CONFIGS=("starship")

for folder in "${FOLDERS[@]}"; do
  rm -rf "$CONFIG_DIR/$folder"
  mkdir -p "$CONFIG_DIR/$folder"
  stow --target="$CONFIG_DIR/$folder" "$folder"
done

for config in "${FLAT_CONFIGS[@]}"; do
  rm -f "$CONFIG_DIR/$config.toml"
  stow --target="$CONFIG_DIR" "$config"
done

log "Stowing .gitconfig"
rm -f "$HOME/.gitconfig"
stow --target="$HOME" git

log "Installing fonts"
cd ..
mkdir -p "$HOME/.local/share/fonts"
stow --target="$HOME/.local/share/fonts" fonts

log "Setup complete!"
