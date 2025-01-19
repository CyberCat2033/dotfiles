#!/bin/bash

current_brightness="$(brightnessctl -m | awk -F, '{print $4}')"

notify-send \
  -i "/usr/share/icons/Tela-circle-black/scalable/devices/display.svg" \
  --hint=int:transient:1 \
  --hint=string:x-canonical-private-synchronous:7777 \
  -u critical \
  "Brightness (eDP)" "$current_brightness"
