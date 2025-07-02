# Aether Forge

## Bootstrap

### NixOS

For cloning the repo you need git. Firefox and Github CLI are also useful.

```sh
nix-shell -p git -p firefox -p gh
```

If using `gh` for cloning the repo:

```sh
gh repo clone JorgeMayoral/AetherForge
```

Copy hardware configuration

```sh
cp /etc/nixos/hardware-configuration.nix ~/AetherForge/nixos
```

Rebuild the system using the flake:

```sh
nixos-rebuild switch --flake ~/AetherForge/nixos#aether --experimental-features 'nix-command flakes'
```

### Archlinux

#### Dependencies

- git
- curl

#### Instructions

```sh
curl https://raw.githubusercontent.com/JorgeMayoral/AetherForge/refs/heads/main/bootstrap/archlinux.sh | bash
```

## Dotfiles

Archlinux bootstrap script add the dotfiles, but for NixOS or doing it manually run this:

```sh
DOTFILES_DIR="$HOME/AetherForge/dotfiles"
CONFIGS=("bat" "bottom" "fish" "ghostty" "helix" "k9s" "nushell" "wezterm" "yazi" "zellij")

cd "$DOTFILES_DIR"

for config in "${CONFIGS[@]}"; do
  rm -rf "$CONFIG_DIR/$folder"
  mkdir -p "$CONFIG_DIR/$folder"
  stow --target="$CONFIG_DIR/$folder" "$folder"
done

stow --target="$HOME/.config" "starship"
stow --target="$HOME" "git"
```
