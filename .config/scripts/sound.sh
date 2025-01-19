#!/bin/bash

VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100.1)}')
ICON_PATH="/usr/share/icons/Tela-circle-black/scalable/apps/volume-knob.svg"

notify-send \
  -i "$ICON_PATH" \
  --hint=int:transient:1 \
  --hint=string:x-canonical-private-synchronous:9999 \
  -u critical \
  "Volume" "${VOLUME}%"
