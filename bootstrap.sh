#!/usr/bin/env bash

set -e

CONFIG_DIR="$HOME/.config"
FOLDERS=("bat" "bottom" "fish" "helix" "k9s" "nushell" "wezterm" "yazi" "zellij")
FLAT_CONFIGS=("starship")

for folder in "${FOLDERS[@]}"; do
  rm -rf "$CONFIG_DIR/$folder"
  mkdir -p "$CONFIG_DIR/$folder"
  stow --target="$CONFIG_DIR/$folder" "$folder"
done

for config in "${FLAT_CONFIGS[@]}"; do
  stow --target="$CONFIG_DIR" "$config"
done

# GIT
stow --target="$HOME" git

# Fonts
mkdir -p "$HOME/.fonts"
stow --target="$HOME/.fonts" fonts
