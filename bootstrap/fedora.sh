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

# --- PACKAGES FROM DNF ---

DNF_PACKAGES=("vim" "wget" "curl" "git" "gnupg" "git-delta" "stow" "rust-bat" "fzf" "helix" "golang" "unzip" "7zip" "zoxide" "fastfetch" "libnotify" "ripgrep" "just" "tmux" "helm" "libreoffice" "gimp" "inkscape" "hexyl" "newsboat")

for pkg in "${DNF_PACKAGES[@]}"; do
    sudo dnf install "$pkg"
done

## --- SPECIAL CASES + COPR ---
sudo dnf install dnf5-plugins

sudo dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install gh --repo gh-cli

sudo dnf copr enable wezfurlong/wezterm-nightly
sudo dnf install wezterm

sudo dnf copr enable atim/bottom -y
sudo dnf install bottom

# --- BINARY DOWNLOADS ---
curl -f https://zed.dev/install.sh | sh

sudo curl -fsSL https://raw.githubusercontent.com/ThatOneCalculator/NerdFetch/main/nerdfetch -o /usr/bin/nerdfetch
sudo chmod +x /usr/bin/nerdfetch

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# --- FLATPAKS ---
flatpak install flathub md.obsidian.Obsidian
flatpak install flathub com.google.Chrome

# --- GO PACKAGES ---
mkdir -p $HOME/go
export GOPATH=$HOME/go

go install github.com/charmbracelet/glow/v2@latest
go install github.com/evilmartians/lefthook@v1.13.6
go install github.com/bitnami-labs/sealed-secrets/cmd/kubeseal@main
go install github.com/derailed/k9s@latest

# --- RUST & CRATES ---

log "Installing Rust with rustup"
if ! command -v rustup >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  . source "$HOME/.cargo/env"
else
  log "Rust already installed"
fi

CARGO_CRATES=("erdtree" "bacon" "eza" "starship" "tealdeer" "nushell" "xh" "yazi" "zellij" "git-cliff" "hexhog")

for crate in"${CARGO_CRATES[@]}"; do
    cargo install --locked "$crate"
done

# --- FNM ---

log "Installing FNM"
if [ ! -d "$HOME/.fnm" ]; then
  curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "$HOME/.fnm" --skip-shell
else
  log "FNM already installed"
fi

# --- UV ---

log "Installing UV"
if ! command -v uv >/dev/null 2>&1; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
else
    log "UV already installed"
fi

# --- DOTFILES ---

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

FOLDERS=("bat" "bottom" "fish" "helix" "k9s" "nushell" "wezterm" "yazi" "zed" "zellij" "tmux" "newsboat")
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

# --- STYLING --
## FONTS
cd "$DOTFILES_DIR/fonts"
cp -r * /usr/share/fonts

## CURSORS
mkdir -p /usr/share/icons
cd /usr/share/icons
curl -LOsS https://github.com/catppuccin/cursors/releases/download/v2.0.0/catppuccin-mocha-sky-cursors.zip
curl -LOsS https://github.com/catppuccin/cursors/releases/download/v2.0.0/catppuccin-latte-sky-cursors.zip
unzip catppuccin-mocha-sky-cursors.zip
unzip catppuccin-latte-sky-cursors.zip

## ICONS
cd /tmp
git clone https://github.com/catppuccin/papirus-folders.git
cd papirus-folders
sudo cp -r src/* /usr/share/icons/Papirus
curl -LO https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-folders/master/papirus-folders && chmod +x ./papirus-folders
./papirus-folders -C cat-mocha-sky --theme Papirus-Dark
./papirus-folders -C cat-latte-sky --theme Papirus-Light

# ---------

log "Setup complete!"
