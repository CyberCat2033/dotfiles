#!/usr/bin/env bash

set -u

SOCKET="${MPV_WALLPAPER_SOCKET:-/tmp/mpv-socket}"
STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/wallpaper-paused"
SYNC_ID="string:x-canonical-private-synchronous:9999"
PAUSED_ICON="/usr/share/icons/Tela-circle-black/24/panel/media-playback-paused.svg"
PLAYING_ICON="/usr/share/icons/Tela-circle-black/24/panel/exaile-play.svg"
ERROR_ICON="/usr/share/icons/Tela-circle-black/scalable/apps/script-error.svg"

notify() {
  notify-send \
    --hint=int:transient:1 \
    --hint="$SYNC_ID" \
    -u critical \
    -i "$1" \
    "Wallpaper" "$2"
}

have_process() {
  pgrep -x "$1" >/dev/null 2>&1
}

require_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    notify "$ERROR_ICON" "$1 is not installed"
    exit 1
  fi
}

require_socket() {
  if [[ ! -S "$SOCKET" ]]; then
    notify "$ERROR_ICON" "IPC socket is not available"
    exit 1
  fi
}

mpvpaper_toggle() {
  require_cmd jq

  local response paused
  response="$(
    printf '%s\n' \
      '{"command":["cycle","pause"],"request_id":1}' \
      '{"command":["get_property","pause"],"request_id":2}' |
      socat -t 0.3 - UNIX-CONNECT:"$SOCKET" 2>/dev/null
  )"

  paused="$(
    printf '%s\n' "$response" |
      jq -r 'select(.request_id == 2 and .error == "success") | .data' 2>/dev/null |
      tail -n 1
  )"

  case "$paused" in
  true)
    notify "$PAUSED_ICON" "Paused"
    ;;
  false)
    notify "$PLAYING_ICON" "Resumed"
    ;;
  *)
    notify "$ERROR_ICON" "Could not read mpvpaper state"
    exit 1
    ;;
  esac
}

gslapper_paused() {
  local response
  response="$(printf 'paused\n' | socat -t 0.3 - UNIX-CONNECT:"$SOCKET" 2>/dev/null || true)"

  case "$response" in
  *paused=1*)
    printf 'true\n'
    ;;
  *paused=0*)
    printf 'false\n'
    ;;
  *)
    return 1
    ;;
  esac
}

gslapper_send() {
  printf '%s\n' "$1" | socat -t 0.3 - UNIX-CONNECT:"$SOCKET" >/dev/null 2>&1
}

gslapper_toggle() {
  local paused

  if paused="$(gslapper_paused)"; then
    if [[ "$paused" == "true" ]]; then
      gslapper_send resume
      rm -f "$STATE_FILE"
      notify "$PLAYING_ICON" "Resumed"
    else
      gslapper_send pause
      touch "$STATE_FILE"
      notify "$PAUSED_ICON" "Paused"
    fi
    return
  fi

  if [[ -f "$STATE_FILE" ]]; then
    gslapper_send resume
    rm -f "$STATE_FILE"
    notify "$PLAYING_ICON" "Resumed"
  else
    gslapper_send pause
    touch "$STATE_FILE"
    notify "$PAUSED_ICON" "Paused"
  fi
}

require_cmd socat
require_socket

if have_process mpvpaper; then
  mpvpaper_toggle
elif have_process gslapper || have_process gslapper-holder || have_process slapper; then
  gslapper_toggle
else
  notify "$ERROR_ICON" "Live wallpaper process is not running"
  exit 1
fi
