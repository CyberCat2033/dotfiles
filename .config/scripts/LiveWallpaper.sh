#!/bin/bash

if lspci -d ::03xx | grep "Intel"; then
  export LIBVA_DRIVER_NAME=iHD
  mpvpaper -o "input-ipc-server=/tmp/mpv-socket no-audio hwdec=vaapi gpu-api=opengl gpu-context=wayland --no-config --loop" "*" "$LIVE_WALLPAPER_PATH"
else
  mpvpaper -p --mpv-options "input-ipc-server=/tmp/mpv-socket --load-scripts=no no-audio" "*" "$LIVE_WALLPAPER_PATH"
fi
