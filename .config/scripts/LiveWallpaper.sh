#!/bin/bash
if lspci -d ::03xx | grep "RTX" >>/dev/null; then
  killall gslapper
  gslapper -f -v -o "loop no-audio" '*' "$LIVE_WALLPAPER_PATH"
  # env __GLX_VENDOR_LIBRARY_NAME=mesa __EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json MESA_LOADER_DRIVER_OVERRIDE=zink GALLIUM_DRIVER=zink LIBGL_KOPPER_DRI2=1 mpvpaper -f -p --mpv-options " input-ipc-server=/tmp/mpv-socket --loop --load-scripts=no no-audio" "*" "$LIVE_WALLPAPER_PATH"
else
  export LIBVA_DRIVER_NAME=iHD
  killall mpvpaper
  mpvpaper -o "input-ipc-server=/tmp/mpv-socket no-audio hwdec=vaapi gpu-api=opengl gpu-context=wayland --no-config --loop" "*" "$LIVE_WALLPAPER_PATH"
fi
