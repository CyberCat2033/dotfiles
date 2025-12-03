#!/bin/bash

cover_path="/tmp/playerctl_cover.jpg"
rounded_cover="/tmp/playerctl_cover_rounded.png"
cache_metadata="/tmp/playerctl_last_metadata.txt"

# 🔥1: grep cmus (15мс)
activeplayer=$(playerctl -l 2>/dev/null | head -n1)
if [ "$activeplayer" = cmus ]; then
  # ✅ ВАШ AWK (8мс)
  metadata=$(cmus-remote -Q | awk '
    /^tag artist/ {artist=substr($0, index($0,$3))}
    /^tag album / {album=substr($0, index($0,$3))}
    /^tag albumartist/ {albumartist=substr($0, index($0,$3))}
    /^tag title/ {title=substr($0, index($0,$3))}
    /^file/ {file=substr($0, index($0,$2))}
    /^status/ {status=toupper(substr($2,1,1)) substr($2,2)}
    END {print artist "§" album "§" albumartist "§" title "§" file "§" status}')
  IFS=§ read -r artist album albumartist title file status <<<"$metadata"
  [ -z "$artist" ] && artist="$albumartist"
  current_metadata="$album"
  ~/.config/scripts/bins/extract_album_art -i "$file" -o "$cover_path"

else
  # ✅ SLEEP для Yandex Music (550мс)
  sleep 0.55
  metadata=$(playerctl metadata --format '{{mpris:artUrl}}§{{status}}§{{artist}}§{{album}}§{{title}}')
  IFS=§ read -r file status artist album title <<<"$metadata"
  file=${file#file://}
  if [ -f "$file" ]; then
    cp "$file" "$cover_path"
  fi
  current_metadata="$album"
fi

# 🔥2: КЭШ { } (3мс)
last_metadata=$(cat "$cache_metadata" 2>/dev/null)
[ "$current_metadata" = "$last_metadata" ] && [ "$current_metadata" != "" ] && {
  notify-send --hint=int:transient:1 --hint=string:x-canonical-private-synchronous:8888 -i "$rounded_cover" -u critical -t 1488 "$status" "$artist"$'\n'"$title"
  exit 0
}
echo "$current_metadata" >"$cache_metadata"

# 🔥3: ✅ ИСПРАВЛЕНО! [ ] && [ ] (+1мс)
# [ "$activeplayer" = cmus ] && [ -f "$file" ] && ~/.config/scripts/bins/extract_album_art -i "$file" -o "$cover_path"

if [ -f "$cover_path" ]; then
  [ ! -e "/tmp/image_processor" ] && ~/.config/scripts/bins/image_processor
  echo -n process | socat - UNIX-CONNECT:/tmp/image_processor
else
  # rounded_cover="/usr/share/icons/Tela-circle-black/scalable/apps/com.github.neithern.g4music.svg"
  rounded_cover="/usr/share/icons/Tela-circle-black/scalable/apps/com.github.neithern.g4music.svg"
fi

# 🔥4: notify (1мс)
notify-send --hint=int:transient:1 --hint=string:x-canonical-private-synchronous:8888 -i "$rounded_cover" -u critical -t 1488 "$status" "$artist"$'\n'"$title"
