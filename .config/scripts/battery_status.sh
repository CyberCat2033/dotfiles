#!/usr/bin/env bash

############ Variables ############
enable_battery=false
battery_charging=false
battery_capacity=0

####### Check availability ########
for battery in /sys/class/power_supply/*BAT*; do
  if [[ -f "$battery/uevent" ]]; then
    enable_battery=true
    battery_capacity=$(cat "$battery/capacity")
    if [[ $(cat "$battery/status") != "Discharging" ]]; then
      battery_charging=true
    fi
    break
  fi
done

############# Output #############
if [[ $enable_battery == true ]]; then
  if [[ $battery_charging == true ]]; then
    echo -n " "
  fi
  if ((battery_capacity >= 80)); then
    echo -n "  "
  elif ((battery_capacity >= 60)); then
    echo -n "  "
  elif ((battery_capacity >= 40)); then
    echo -n "  "
  elif ((battery_capacity >= 20)); then
    echo -n "  "
  else
    echo -n "  "
  fi
  echo -n "$battery_capacity%"
fi
