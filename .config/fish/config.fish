oh-my-posh init fish --config "~/.config/fish/rudolfs-dark.omp.json" | source

fastfetch

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Created by `pipx` on 2024-05-02 10:23:33
set PATH $PATH /home/cybercat/.local/bin
alias hyprconfig="cd ~/.config/hypr;  env EDITOR=nvim ranger"
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
# set -g theme_display_user yes
