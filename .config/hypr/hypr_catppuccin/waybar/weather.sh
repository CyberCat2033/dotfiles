#!/bin/bash

str=$(curl -s wttr.in/Moscow?format="%C+%t")
temp=$(echo "$str" | awk '{print $NF}')
condition=$(echo "$str" | awk '{$NF=""; print $0}' | sed 's/[[:space:]]*$//')

case "$condition" in
"Sunny" | "Clear")
  ICON=" "
  ;;
"Partly cloudy" | "Partly" | "Partly sunny" | "PartlySunny")
  ICON=" " # U+26C5
  ;;
"Cloudy" | "Overcast")
  ICON=" " # U+2601
  ;;
"Rain" | "Light" | "Showers")
  ICON=" " # U+1F327
  ;;
"Thunderstorm" | "Storm" | "Thunder")
  ICON=" " # U+26C8
  ;;
"Snow" | "Snow_Showers" | "Light_Snow")
  ICON=" " # U+2744
  ;;
"Fog" | "Mist" | "Haze" | "Light rain shower, mist")
  ICON="󰖑 " # U+1F32B
  ;;
"Windy" | "Breezy")
  ICON="󰖝 " # U+1F4A8
  ;;
*)
  ICON="" # U+2753
  ;;
esac

echo "$ICON$temp"
