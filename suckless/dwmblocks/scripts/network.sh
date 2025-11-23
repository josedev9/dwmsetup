#!/bin/bash

~/dwmsetup/suckless/dwmblocks/scripts/themes/onedark.sh

# Colors (dwmblocks expects ^cCOLOR^ )
GREEN="#00ff00"
RED="#ff5555"
YELLOW="#f1fa8c"
BLUE="#8be9fd"
MAGENTA="#ff79c6"

color() {
  printf "^c%s^%s^d^" "$1" "$2"
}

# Get active interfaces (UP and RUNNING)
active_ifaces=$(ls /sys/class/net | while read -r iface; do
  if [[ "$(cat /sys/class/net/$iface/operstate 2>/dev/null)" == "up" ]]; then
    printf "%s " "$iface"
  fi
done)

# If no interface is active
if [[ -z "$active_ifaces" ]]; then
  printf "^c$RED^❌ No Network^d^"
  exit 0
fi

# Calculate network speed
# Store previous values in /tmp
read rx_prev tx_prev < /tmp/netusage 2>/dev/null
rx_curr=0
tx_curr=0

for iface in $active_ifaces; do
  rx=$(cat /sys/class/net/$iface/statistics/rx_bytes 2>/dev/null)
  tx=$(cat /sys/class/net/$iface/statistics/tx_bytes 2>/dev/null)
  rx_curr=$((rx_curr + rx))
  tx_curr=$((tx_curr + tx))
done

# Save current values for next run
printf "%s %s\n" "$rx_curr" "$tx_curr" > /tmp/netusage

# If first run – no data to compute speed yet
if [[ -z "$rx_prev" ]]; then
  printf "^c$YELLOW^🛜 Init...^d^"
  exit 0
fi

# Calculate speed (bytes per second)
rx_rate=$((rx_curr - rx_prev))
tx_rate=$((tx_curr - tx_prev))

# Convert to human readable
human() {
  local rate=$1
  if (( rate > 1024 * 1024 )); then
    printf "%.1fMB/s" "$(echo "$rate / 1024 / 1024" | bc -l)"
  elif (( rate > 1024 )); then
    printf "%.1fKB/s" "$(echo "$rate / 1024" | bc -l)"
  else
    printf "%dB/s" "$rate"
  fi
}

rx_h=$(human "$rx_rate")
tx_h=$(human "$tx_rate")

# Detect connection type
iface=$(echo "$active_ifaces" | awk '{print $1}')  # first active interface

if [[ "$iface" == w* ]]; then
  icon="🛜"  # WiFi
elif [[ "$iface" == e* ]]; then
  icon="🔌"  # Ethernet
else
  icon="🌐"
fi

# Final print
printf "^c$GREEN^%s %s^d^ " "$icon" "$active_ifaces"
printf "^c$BLUE^↓ %s ^d^" "$rx_h"
printf "^c$MAGENTA^↑ %s^d^" "$tx_h"

