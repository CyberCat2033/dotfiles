#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Power Menu
#
## Available Styles
#
## style-1   style-2   style-3   style-4   style-5
dir="~/.config/hypr/Ayanami_Ray/rofi/powermenu/type-4"
theme='style-3'

uptime="$(uptime -p | sed -e 's/up //g')"
host=$(hostname)

shutdown='⏻'
reboot=''
lock='󰍁'
suspend=''
logout='󰍃'
yes=''
no=''

rofi_cmd() {
  rofi -dmenu \
    -p "Goodbye ${USER}" \
    -mesg "Uptime: $uptime" \
    -theme ${dir}/${theme}.rasi
}

confirm_cmd() {
  rofi -dmenu \
    -p 'Confirmation' \
    -mesg 'Are you sure?' \
    -theme ${dir}/shared/confirm.rasi
}

confirm_exit() {
  echo -e "$yes\n$no" | confirm_cmd
}

run_rofi() {
  echo -e "$shutdown\n$lock\n$suspend\n$logout\n$reboot" | rofi_cmd
}

run_cmd() {
  selected="$(confirm_exit)"
  if [[ "$selected" == "$yes" ]]; then
    case $1 in
    '--shut')
      echo "Shutting down..."
      sleep 0.5
      systemctl poweroff
      ;;
    '--sus')
      echo "Suspending..."
      mpc -q pause
      amixer set Master mute
      systemctl suspend
      sleep 3
      hyprlock -c ~/.config/hypr/Ayanami_Ray/hyprlock/hyprlock.conf
      ;;
    '--reboot')
      echo "Rebooting..."
      sleep 0.5
      systemctl reboot
      ;;
    '--logout')
      echo "Logging out..."
      sleep 0.2
      hyprctl dispatch exit
      # loginctl terminate-user ""
      # loginctl terminate-session "$XDG_SESSION_ID"
      # systemctl --user stop wayland-wm@*.service
      # uwsm stop
      ;;
    *)
      echo "Unknown command!"
      ;;
    esac
  else
    exit 0
  fi
}

# Actions
chosen=$(run_rofi | xargs)    # Trim the input
echo "Chosen action: $chosen" # Debug output

case ${chosen} in
"$shutdown")
  echo "Shutdown selected"
  run_cmd --shut
  ;;
"$reboot")
  echo "Reboot selected"
  run_cmd --reboot
  ;;
"$lock")
  echo "Lock selected"
  sleep 0.1
  hyprlock -c ~/.config/hypr/Ayanami_Ray/hyprlock/hyprlock.conf
  ;;
"$suspend")
  echo "Suspend selected"
  (systemctl suspend | sleep 0.5 && hyprlock -c ~/.config/hypr/Ayanami_Ray/hyprlock/hyprlock.conf) || loginctl suspend
  ;;
"$logout")
  echo "Logout selected"
  run_cmd --logout
  ;;
*)
  echo "No valid option selected!"
  ;;
esac
