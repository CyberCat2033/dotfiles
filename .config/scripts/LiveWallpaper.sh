#!/bin/bash

if lspci -d ::03xx | grep "Intel"; then
  export LIBVA_DRIVER_NAME=iHD
  mpvpaper -o "input-ipc-server=/tmp/mpv-socket no-audio hwdec=vaapi --loop" "*" "$LIVE_WALLPAPER_PATH"
else
  mpvpaper -o "input-ipc-server=/tmp/mpv-socket no-audio hwdec=auto --loop" "*" "$LIVE_WALLPAPER_PATH"
fi
