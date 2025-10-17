#!/bin/bash

cover_path="/tmp/playerctl_cover.jpg"
rounded_cover="/tmp/playerctl_cover_rounded.png"
cache_metadata="/tmp/playerctl_last_metadata.txt"

activeplayer=$(playerctl -l 2>/dev/null)

if [ "$activeplayer" == "cmus" ]; then
  # Извлечение метаданных из cmus за один раз
  metadata=$(cmus-remote -Q | awk '
    /^tag artist/ {artist=substr($0, index($0,$3))}
    /^tag album / {album=substr($0, index($0,$3))}
    /^tag albumartist/ {albumartist=substr($0, index($0,$3))}
    /^tag title/ {title=substr($0, index($0,$3))}
    /^file/ {file=substr($0, index($0,$2))}
    /^status/ {status=toupper(substr($2,1,1)) substr($2,2)}
    END {print artist "§" album "§" albumartist "§" title "§" file "§" status}')

  IFS='§' read -r artist album albumartist title file status <<<"$metadata"

  if [ -z "$artist" ]; then
    artist="$albumartist"
  fi

  current_metadata="$album"
  last_metadata=$(cat "$cache_metadata" 2>/dev/null || echo "")
  if [ "$current_metadata" == "$last_metadata" ]; then
    notify-send --hint=int:transient:1 --hint=string:x-canonical-private-synchronous:8888 -i "$rounded_cover" -u critical -t 1488 "$status" "$artist\n$title"
    exit 0
  fi
  echo "$current_metadata" >"$cache_metadata"

  ~/.config/scripts/bins/extract_album_art -i "$file" -o "$cover_path" || rm -f "$cover_path"
else
  sleep 0.55
  metadata=$(playerctl metadata --format '{{mpris:artUrl}}§{{status}}§{{artist}}§{{album}}§{{title}}' 2>/dev/null)
  IFS='§' read -r cover_url status artist album title <<<"$metadata"

  if [ -n "$album" ]; then
    echo "$album"
    current_metadata="$album"
    last_metadata=$(cat "$cache_metadata" 2>/dev/null || echo "")
    if [ "$current_metadata" == "$last_metadata" ]; then
      notify-send --hint=int:transient:1 --hint=string:x-canonical-private-synchronous:8888 -i "$rounded_cover" -u critical -t 1488 "$status" "$artist\n$title"
      exit 0
    fi
  fi
  echo "$current_metadata" >"$cache_metadata"
  curl -sL "$cover_url" -o "$cover_path"
fi

if [ -f "$cover_path" ]; then

  [ -e "/tmp/image_processor" ] || ~/.config/scripts/bins/image_processor
  echo -n "process" | socat - UNIX-CONNECT:/tmp/image_processor
else
  cp "/usr/share/icons/Tela-circle-black/scalable/apps/com.github.neithern.g4music.svg" "$rounded_cover"
  rounded_cover="/usr/share/icons/Tela-circle-black/scalable/apps/com.github.neithern.g4music.svg"
fi

notify-send --hint=int:transient:1 --hint=string:x-canonical-private-synchronous:8888 -i "$rounded_cover" -u critical -t 1488 "$status" "$artist\n$title"

debug_players() {
  echo "=== DEBUG PLAYERS ===" >&2
  echo "All players:" >&2
  echo "$all_players" >&2
  echo "Selected: $activeplayer" >&2
  echo "==================" >&2
}

# Раскомментируйте строку ниже для отладки
# debug_players
