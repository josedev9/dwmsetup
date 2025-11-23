#!/bin/sh
. ~/dwmsetup/suckless/dwmblocks/scripts/themes/onedark.sh
# Change BAT0 to BAT1 if your system uses a different name
BAT="/sys/class/power_supply/BAT0"
AC="/sys/class/power_supply/AC"

# Read battery capacity
capacity=$(cat "$BAT/capacity" 2>/dev/null)

# Read charging status
status=$(cat "$BAT/status" 2>/dev/null)

# icons (optional)
charging_icon=""
full_icon=""
medium_icon=""
low_icon=""
critical_icon=""

# Select icon based on charge level
if [ "$status" = "Charging" ]; then
    icon="$charging_icon"
elif [ "$capacity" -ge 80 ]; then
    icon="$full_icon"
elif [ "$capacity" -ge 50 ]; then
    icon="$medium_icon"
elif [ "$capacity" -ge 20 ]; then
    icon="$low_icon"
else
    icon="$critical_icon"
fi

# Output for dwmblocks
printf "^c#00ff00^$icon $capacity%%"

