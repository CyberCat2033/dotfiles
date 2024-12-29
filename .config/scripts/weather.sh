#!/bin/bash

str=$(curl -s wttr.in/Moscow?format="%C+%t")
temp=$(echo "$str" | awk '{print $NF}')
condition=$(echo "$str" | awk '{$NF=""; print $0}' | sed 's/[[:space:]]*$//')

case "$condition" in
*Sunny* | *Clear*)
  ICON=" " # Sunny or Clear
  ;;
*Partly* | *Partly*Sunny* | *Partly*cloudy*)
  ICON=" " # Partly Sunny or Cloudy
  ;;
*Cloudy* | *Overcast*)
  ICON=" " # Cloudy or Overcast
  ;;
*Rain* | *Light* | *Showers*)
  ICON=" " # Rain or Showers
  ;;
*Thunder* | *Storm*)
  ICON=" " # Thunderstorm or Storm
  ;;
*Snow* | *Freezing* | *Light*Snow*)
  ICON=" " # Snow or Freezing drizzle
  ;;
*Fog* | *Mist* | *Haze* | *Light*rain*shower* | *mist*)
  ICON="󰖑 " # Fog, Mist, or Haze
  ;;
*Windy* | *Breezy*)
  ICON="󰖝 " # Windy or Breezy
  ;;
*)
  ICON="" # Unknown
  ;;
esac

if [ "$temp" == "processed" ]; then
  exit 1
fi

echo "$ICON$temp"
