#!/bin/bash

if (hyprctl monitors all | grep "HDMI" >>/dev/null); then
  current_brightness="$(ddcutil getvcp 10 | sed -n 's/.*current value = *\([0-9]\+\).*/\1/p')"
  notify-send \
    -i "/usr/share/icons/Tela-circle-black/scalable/devices/display.svg" \
    --hint=int:transient:1 \
    --hint=string:x-canonical-private-synchronous:7777 \
    -u critical \
    "Brightness (HDMI)" "$current_brightness%"

fi
