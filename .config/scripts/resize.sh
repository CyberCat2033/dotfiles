#!/bin/bash

ICON="/usr/share/icons/Tela-circle-black/scalable/apps/org.xfce.settings.display.svg"
URGENCY="critical"
TRANSIENT="int:transient:1"
SYNC_ID="string:x-canonical-private-synchronous:9999"
TITLE="Resize"

# Сообщение из аргумента запуска
MESSAGE="$1"

notify-send -i "$ICON" -u "$URGENCY" \
  --hint="$TRANSIENT" \
  --hint="$SYNC_ID" \
  "$TITLE" "$MESSAGE"
