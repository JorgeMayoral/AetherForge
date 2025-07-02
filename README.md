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
cd ~/AetherForge/dotfiles
stow --target="$HOME/.config/bat" "bat"
stow --target="$HOME/.config/bottom" "bottom"
stow --target="$HOME/.config/fish" "fish"
stow --target="$HOME/.config/ghostty" "ghostty"
stow --target="$HOME/.config/helix" "helix"
stow --target="$HOME/.config/k9s" "k9s"
stow --target="$HOME/.config/nushell" "nushell"
stow --target="$HOME/.config/wezterm" "wezterm"
stow --target="$HOME/.config/yazi" "yazi"
stow --target="$HOME/.config/zellij" "zellij"
stow --target="$HOME/.config" "starship"
stow --target="$HOME" "git"
```
