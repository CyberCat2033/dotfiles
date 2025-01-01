#!/bin/bash

# Получаем статус mute через wpctl
muted_status=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -oE '\[MUTED\]')

# Определяем сообщение на основе статуса
if [ -n "$muted_status" ]; then
  mute_message="Unmuted"
  wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
else
  mute_message="Muted"
  wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
fi

# Отправляем уведомление
notify-send \
  --hint=int:transient:1 \
  --hint=string:x-canonical-private-synchronous:9999 \
  -u critical \
  -i "/usr/share/icons/Tela-circle-black/scalable/apps/volume-knob.svg" \
  "$mute_message"
