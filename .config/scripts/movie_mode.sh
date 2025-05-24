#!/bin/bash
killall -SIGUSR1 waybar
active_monitor=$(hyprctl activewindow | sed -n 's/.*monitor: \([0-9]*\).*/\1/p')
if [ "$active_monitor" == "0" ]; then
  curent_mode=$(ddcutil getvcp DC | sed -n 's/.*sl=0x\([0-9a-fA-F]*\).*/\1/p')
  if [ "$curent_mode" == "02" ]; then
    ddcutil setvcp DC 3
  else
    ddcutil setvcp DC 2
  fi
fi
