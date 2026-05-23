#!/bin/bash
child_pid=""

cleanup() {
  if [ -n "$child_pid" ] && kill -0 "$child_pid" >/dev/null 2>&1; then
    kill "$child_pid" >/dev/null 2>&1 || true
    sleep 0.5
    kill -KILL "$child_pid" >/dev/null 2>&1 || true
  fi
}

trap cleanup INT TERM EXIT

if lspci -d ::03xx | grep "RTX" >>/dev/null; then
  killall gslapper >/dev/null 2>&1 || true
  gslapper -I /tmp/mpv-socket -o "loop no-audio" '*' "$LIVE_WALLPAPER_PATH" &
  # env __GLX_VENDOR_LIBRARY_NAME=mesa __EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json MESA_LOADER_DRIVER_OVERRIDE=zink GALLIUM_DRIVER=zink LIBGL_KOPPER_DRI2=1 mpvpaper -f -p --mpv-options " input-ipc-server=/tmp/mpv-socket --loop --load-scripts=no no-audio" "*" "$LIVE_WALLPAPER_PATH"
else
  export LIBVA_DRIVER_NAME=iHD
  killall mpvpaper >/dev/null 2>&1 || true
  mpvpaper -o "input-ipc-server=/tmp/mpv-socket no-audio hwdec=vaapi gpu-api=opengl gpu-context=wayland --no-config --loop" "*" "$LIVE_WALLPAPER_PATH" &
fi

child_pid=$!
wait "$child_pid"
