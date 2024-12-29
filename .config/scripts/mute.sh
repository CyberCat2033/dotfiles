#!/bin/bash

muted_status=$(pulsemixer --get-mute)
if [ "$muted_status" -eq 1 ]; then
  mute_message="Unmuted"
else
  mute_message="Muted"
fi

pulsemixer --toggle-mute
notify-send -r 9999 -u critical -i "/usr/share/icons/Tela-circle-black/scalable/apps/volume-knob.svg" "$mute_message"
