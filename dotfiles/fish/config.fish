# Path
#set -Ux fish_user_paths $fish_user_paths $HOME/.fnm
set -Ux fish_user_paths $fish_user_paths $HOME/.local/bin
set -Ux fish_user_paths $fish_user_paths $HOME/AetherForge/scripts

if status is-interactive
    # Disable greeting
    set fish_greeting

    # Alias
    alias l="eza -lah --icons=always"
    alias ls="eza --icons=always"
    alias cat="bat -p"

    starship init fish | source
end
