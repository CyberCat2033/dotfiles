#!/bin/bash
status=$(playerctl status 2>/dev/null)

case $status in
Playing)
  icon=""
  ;;
Paused)
  icon=""
  ;;
*)
  icon=""
  ;;
esac

metadata=$(playerctl metadata --format '{{title}}' 2>/dev/null)

if [[ -z "$metadata" ]]; then
  echo ""
  exit 1
fi

echo -e "{\"text\": \""$metadata"\",\"alt\": \""$icon"\",}"
