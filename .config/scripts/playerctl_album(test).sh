#!/bin/bash

cover_path="/tmp/playerctl_cover.jpg"
rounded_cover="/tmp/playerctl_cover_rounded.png"
cache_cover="/tmp/playerctl_last_cover.url"

# Определение активного плеера
activeplayer=$(playerctl -l 2>/dev/null)

if [ "$activeplayer" == "cmus" ]; then
  # Извлечение метаданных из cmus
  metadata=$(cmus-remote -Q)
  artist=$(echo "$metadata" | awk -F ' ' '/^tag artist/ { $1=$2=""; print substr($0,3) }')
  title=$(echo "$metadata" | awk -F ' ' '/^tag title/ { $1=$2=""; print substr($0,3) }')
  file=$(echo "$metadata" | awk -F ' ' '/^file/ { $1=""; print substr($0,2) }')
  status=$(echo "$metadata" | awk -F ' ' '/^status/ { $1=""; $0=substr($0,2); print toupper(substr($0,1,1)) substr($0,2) }')
  # status=$(echo "$metadata" | awk -F ' ' '/^status/ { $1=""; print substr($0,2) }')

  if [ -f "$file" ]; then
    ffmpeg -y -i "$file" -an -vcodec copy "$cover_path" &>/dev/null || rm -f "$cover_path"
  else
    rm -f "$cover_path"
  fi
else
  sleep 0.78
  metadata=$(playerctl metadata --format '{{mpris:artUrl}}|{{status}}|{{artist}}|{{title}}' 2>/dev/null)
  IFS='|' read -r cover_url status artist title <<<"$metadata"

  if [ -n "$cover_url" ] && [ "$cover_url" != "$(cat "$cache_cover" 2>/dev/null)" ]; then
    curl -sL "$cover_url" -o "$cover_path" && echo "$cover_url" >"$cache_cover"
  fi
fi

if [ -f "$cover_path" ]; then
  magick "$cover_path" \
    -resize 128x128^ \
    -gravity center \
    -extent 128x128 \
    \( +clone -alpha extract \
    -draw "fill black rectangle 0,0 128,128 fill white circle 64,64 64,0" \
    -alpha off \) \
    -compose CopyOpacity -composite \
    "$rounded_cover"
else
  rounded_cover="/usr/share/icons/Tela-circle-black/scalable/apps/com.github.neithern.g4music.svg"
fi

# echo "Player: $activeplayer"
# echo $status
# echo "Artist: $artist, Title: $title, File: $file"
# echo $rounded_cover
notify-send --hint=string:x-canonical-private-synchronous:8888 -i "$rounded_cover" -u critical -t 1488 "$status" "$artist\n$title"
