#!/bin/bash
status=$(playerctl status 2>/dev/null)

metadata=$(playerctl metadata --format '{{title}}' 2>/dev/null)

if [[ -z "$metadata" ]]; then
  echo ""
  exit 1
fi

echo -e "{\"text\": \""$metadata"\",\"alt\": \""$status"\",}"
