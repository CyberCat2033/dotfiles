#!/usr/bin/env bash
set -u

fallback="/home/cybercat/.config/hypr/Catppuccin_lua/rofi/images/witch1.jpg"
fallback_pid=""

if command -v swaybg >/dev/null 2>&1 && [ -r "$fallback" ]; then
  swaybg -i "$fallback" -m fill &
  fallback_pid=$!
fi

if [ -x "$HOME/.config/scripts/LiveWallpaper.sh" ]; then
  sleep 1
  "$HOME/.config/scripts/LiveWallpaper.sh" &
  live_pid=$!

  (
    sleep 4
    if [ -n "$fallback_pid" ] && kill -0 "$live_pid" >/dev/null 2>&1; then
      kill "$fallback_pid" >/dev/null 2>&1 || true
    fi
  ) &
fi
