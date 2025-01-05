#!/usr/bin/env bash

# Function to find touchpad name from either mice or touch sections
get_touchpad_name() {
  local touchpad_name=$(hyprctl devices -j | jq -r '
    .mice[]?, .touch[]? | select(.name | test("touchpad"; "i")).name' | head -n 1)
  echo "$touchpad_name"
}

# Get the touchpad name dynamically
TOUCHPAD_NAME=$(get_touchpad_name)

# Check if touchpad is found
if [ -z "$TOUCHPAD_NAME" ]; then
  notify-send \
    -i "/usr/share/icons/Tela-circle-black/scalable/devices/input-touchpad.svg" \
    --hint=int:transient:1 \
    --hint=string:x-canonical-private-synchronous:7777 \
    -u critical \
    "Touchpad" "Touchpad device not found."
  exit 1
fi

# Get the current state of the touchpad
TOUCHPAD_STATE=$(hyprctl devices -j | jq --arg name "$TOUCHPAD_NAME" '
  (.mice[]?, .touch[]? | select(.name == $name)).enabled // false')

if [ "$TOUCHPAD_STATE" == "true" ]; then
  # Disable the touchpad
  hyprctl input "$TOUCHPAD_NAME" disable
  notify-send \
    -i "/usr/share/icons/Tela-circle-black/scalable/devices/input-touchpad.svg" \
    --hint=int:transient:1 \
    --hint=string:x-canonical-private-synchronous:7777 \
    -u critical \
    "Touchpad" "Touchpad disabled."
else
  # Enable the touchpad
  hyprctl input "$TOUCHPAD_NAME" enable
  notify-send \
    -i "/usr/share/icons/Tela-circle-black/scalable/devices/input-touchpad.svg" \
    --hint=int:transient:1 \
    --hint=string:x-canonical-private-synchronous:7777 \
    -u critical \
    "Touchpad" "Touchpad enabled."
fi
