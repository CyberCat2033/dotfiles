oh-my-posh init fish --config "~/.config/fish/rudolfs-dark.omp.json" | source
zoxide init fish | source
fastfetch -l $FASTFETCH_LOGO_PATH

if status is-interactive
    # Commands to run in interactive sessions can go here
end
# set -gx ANDROID_HOME /opt/android-sdk
# set -gx ANDROID_SDK_ROOT $ANDROID_HOME
set -gx ANDROID_NDK_ROOT /opt/android-ndk/
set -gx ANDROID_NDK $ANDROID_NDK_ROOT

# set -gx PATH /opt/android-sdk/cmdline-tools/latest/bin $PATH
# set -gx PATH $ANDROID_HOME/platform-tools $PATH
# set -gx PATH $ANDROID_HOME/build-tools/35.0.0 $PATH
# set -gx PATH $HOME/.pub-cache/bin $PATH
# # Created by `pipx` on 2024-05-02 10:23:33
set -gx PATH $HOME/.pub-cache/bin $PATH
set -x PATH $HOME/Android/Sdk/cmdline-tools/latest/bin $PATH
#
# # Android SDK
set -x ANDROID_SDK_ROOT $HOME/Android/Sdk
set -x ANDROID_HOME $ANDROID_SDK_ROOT

# .NET 8 for MAUI
# set -x DOTNET_ROOT $HOME/.dotnet8
# set -x PATH $HOME/.dotnet8 $HOME/.dotnet8/tools $PATH
set -x PATH $HOME/.dotnet/tools $PATH
alias hyprconfig="cd ~/.config/hypr"
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias scripts='cd ~/.config/scripts/'
alias :q='exit'
# alias ls='ls --color=auto'
# alias grep='grep --color=auto'
# set -g theme_display_user yes


# Added by Antigravity CLI installer
set -gx PATH "/home/cybercat/.local/bin" $PATH
