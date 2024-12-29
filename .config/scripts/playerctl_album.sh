#!/bin/bash

cover_path="/tmp/playerctl_cover.jpg"
rounded_cover="/tmp/playerctl_cover_rounded.png"
cache_cover="/tmp/playerctl_last_cover.url"
cache_metadata="/tmp/playerctl_last_metadata.txt"

# Определение активного плеера
activeplayer=$(playerctl -l 2>/dev/null)

if [ "$activeplayer" == "cmus" ]; then
  # Извлечение метаданных из cmus за один раз
  metadata=$(cmus-remote -Q | awk '
    /^tag artist/ {artist=substr($0, index($0,$3))}
    /^tag title/ {title=substr($0, index($0,$3))}
    /^file/ {file=substr($0, index($0,$2))}
    /^status/ {status=toupper(substr($2,1,1)) substr($2,2)}
    END {print artist "|" title "|" file "|" status}')

  IFS='|' read -r artist title file status <<<"$metadata"

  if [ -f "$file" ]; then
    # Извлечение обложки из аудиофайла
    ffmpeg -y -i "$file" -an -vcodec copy "$cover_path" &>/dev/null || rm -f "$cover_path"
  fi
else
  sleep 0.55
  metadata=$(playerctl metadata --format '{{mpris:artUrl}}|{{status}}|{{artist}}|{{title}}' 2>/dev/null)
  IFS='|' read -r cover_url status artist title <<<"$metadata"

  if [ -n "$cover_url" ]; then
    # Проверка изменения URL обложки
    last_cover_url=$(cat "$cache_cover" 2>/dev/null || echo "")
    if [ "$cover_url" != "$last_cover_url" ]; then
      curl -sL "$cover_url" -o "$cover_path" && echo "$cover_url" >"$cache_cover"
    fi
  fi
fi

# Проверка изменений метаданных
current_metadata="$artist|$title"
last_metadata=$(cat "$cache_metadata" 2>/dev/null || echo "")
if [ "$current_metadata" != "$last_metadata" ]; then
  echo "$current_metadata" >"$cache_metadata"

  if [ -f "$cover_path" ]; then
    # Обновляем только если исходная обложка изменилась
    if [ ! -f "$rounded_cover" ] || [ "$cover_path" -nt "$rounded_cover" ]; then
      magick "$cover_path" \
        -resize 128x128^ \
        -gravity center \
        -extent 128x128 \
        \( +clone -alpha extract \
        -draw "fill black rectangle 0,0 128,128 fill white circle 64,64 64,0" \
        -alpha off \) \
        -compose CopyOpacity -composite \
        "$rounded_cover"
    fi
  else
    # Устанавливаем иконку по умолчанию
    cp "/usr/share/icons/Tela-circle-black/scalable/apps/com.github.neithern.g4music.svg" "$rounded_cover"
    rounded_cover="/usr/share/icons/Tela-circle-black/scalable/apps/com.github.neithern.g4music.svg"
  fi
fi

# Уведомление
notify-send -r 8888 -i "$rounded_cover" -u critical -t 1488 "$status" "$artist\n$title"
