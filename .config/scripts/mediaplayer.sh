#!/bin/bash

if pgrep -x "cmus" >/dev/null; then
  workspace=$(hyprctl clients | grep "class:.*cmus")
  if [ -n "$workspace" ]; then
    hyprctl dispatch focuswindow class:cmus

  fi
else
  kitty --class cmus cmus
fi
