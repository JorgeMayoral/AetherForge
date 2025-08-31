{ config, pkgs, ... }:
{
  home.username = "yorch";
  home.homeDirectory = "/home/yorch";

  home.packages = with pkgs; [
    delta
    gh
    stow
    bat
    fzf
    erdtree
    eza
    starship
    tealdeer
    helix
    nushell
    xh
    yazi
    zellij
    glow
    git-cliff
    wezterm
    ghostty
    vscode
    zed-editor
    unzip
    bottom
    zoxide
    kubectl
    kubectx
    kubeseal
    kubernetes-helm
    k9s
    lefthook
    devenv
    # nodejs_24
    nil
    nixfmt-rfc-style
    rustup
    gcc
    uv
    fastfetch
    nerdfetch
    terminaltexteffects
    libnotify
    ripgrep
    google-chrome
    libreoffice
    gimp3
    obsidian
    papers
    simple-scan
    inkscape
    gnome-tweaks
    gnomeExtensions.blur-my-shell
    gnomeExtensions.tophat
    gnomeExtensions.space-bar
    gnomeExtensions.tweaks-in-system-menu
    gnomeExtensions.caffeine

    # Apps for Hyprland
    walker
    waybar
    swayosd
    mako
    catppuccin-cursors.mochaSky
    nordzy-cursor-theme
    nordzy-icon-theme
    hyprpaper
    hyprlock
    hyprpolkitagent
  ];

  home.stateVersion = "25.11";
}
