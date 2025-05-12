# config.nu
#
# Installed by:
# version = "0.102.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.
use std/util "path add"

$env.config.buffer_editor = "code"
$env.config.show_banner = false

# Prompt
# def kube_prompt [] {
#     let k_prompt =  ([(kubectl ns -c)] | str trim)
#     let d_prompt = ([(date now | date format '%r')] | str join)
#     $"\(($k_prompt)\) ($d_prompt)"
# }


$env.PROMPT_INDICATOR = " ➜"
# $env.PROMPT_COMMAND = { $"(pwd | path basename)\n" }
# $env.PROMPT_COMMAND_RIGHT = { kube_prompt }

# PATH
path add "~/.fnm"
