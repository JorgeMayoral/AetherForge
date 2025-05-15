#!/usr/bin/env bash

set -e

# INSTALL YAY
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd "$HOME"

# INSTALL DEPENDENCIES
yay -S git-delta fish github-cli stow bat fzf erdtree eza starship tealdeer helix xh yazi zellij glow wezterm firefox visual-studio-code-bin unzip catppuccin-cursors-mocha papirus-folders-catppuccin-git noto-fonts-emoji adwaita-fonts kubectl kubectx kubeseal helm k9s
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "./.fnm" --skip-shell

# ADD DOTFILES
git clone https://github.com/JorgeMayoral/AetherForge.git 
cd "$HOME/AetherForge"
CONFIG_DIR="$HOME/.config"
FOLDERS=("bat" "bottom" "fish" "helix" "k9s" "nushell" "wezterm" "yazi" "zellij")
FLAT_CONFIGS=("starship")

cd dotfiles

for folder in "${FOLDERS[@]}"; do
  rm -rf "$CONFIG_DIR/$folder"
  mkdir -p "$CONFIG_DIR/$folder"
  stow --target="$CONFIG_DIR/$folder" "$folder"
done

for config in "${FLAT_CONFIGS[@]}"; do
  rm -f "$CONFIG_DIR/starship.toml"
  stow --target="$CONFIG_DIR" "$config"
done

# GIT
rm -f "$HOME/.gitconfig"
stow --target="$HOME" git

cd ..

# Fonts
mkdir -p "$HOME/.fonts"
stow --target="$HOME/.fonts" fonts
