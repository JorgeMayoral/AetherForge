#!/usr/bin/env bash

set -e

set-configs () {
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
}

git clone 

cd "$HOME/AetherForge"

sudo pacman -S git-delta fish github-cli stow bat fzf erdtree eza starship tealdeer helix xh yazi zellij glow wezterm

set-configs
