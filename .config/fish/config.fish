oh-my-posh init fish --config "~/.config/fish/rudolfs-dark.omp.json" | source
zoxide init fish | source
export PKG_CONFIG_PATH=:/usr/lib/pkgconfig
fastfetch -l $FASTFETCH_LOGO_PATH

if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -x PKG_CONFIG_PATH $PKG_CONFIG_PATH /usr/lib/pkgconfig
# Created by `pipx` on 2024-05-02 10:23:33
set PATH $PATH /home/cybercat/.local/bin
set -x PATH /home/.dotnet/tools $PATH
alias hyprconfig="cd ~/.config/hypr"
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias scripts='cd ~/.config/scripts/'
alias :q='exit'
# alias ls='ls --color=auto'
# alias grep='grep --color=auto'
# set -g theme_display_user yes
