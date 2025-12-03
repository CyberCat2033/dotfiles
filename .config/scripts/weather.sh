#!/bin/bash
str=$(curl -s 'wttr.in/Moscow?format=%C+%t' || echo "Unknown +0°C")

temp=$(echo "$str" | awk '{print $NF}')
condition=$(echo "$str" | awk '{$NF=""; print $0}' | sed 's/[[:space:]]*$//' | tr '[:upper:]' '[:lower:]')

# Map condition to icon
case "$condition" in
"* sunny*" | *clear*) ICON=" " ;;             # Sunny / Clear
*partly*cloudy* | *partly*sunny*) ICON=" " ;; # Partly Cloudy
*cloudy* | *overcast*) ICON=" " ;;            # Cloudy
*rain* | *shower* | *drizzle*) ICON=" " ;;    # Rain / Showers
*thunder* | *storm*) ICON=" " ;;              # Thunderstorm
*snow* | *sleet* | *flurr*) ICON=" " ;;       # Snow
*fog* | *mist* | *haze*) ICON="󰖑 " ;;          # Fog / Mist
*wind* | *breez*) ICON="󰖝 " ;;                 # Windy
*) ICON=" " ;;                                # Unknown
esac

printf '{"alt":"%s","text":"%s"}\n' "$ICON" "$temp"
