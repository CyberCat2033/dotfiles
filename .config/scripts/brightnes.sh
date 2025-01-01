#!/bin/bash

current_brightness="$(brightnessctl -m | awk -F, '{print $4}')"

notify-send \
  -i "/usr/share/icons/Tela-circle-black/scalable/apps/nvidia-x-server-setting.svg" \
  --hint=int:transient:1 \
  --hint=string:x-canonical-private-synchronous:7777 \
  "Brightness" "$current_brightness"
