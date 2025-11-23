#!/bin/sh
. ~/dwmsetup/suckless/dwmblocks/scripts/themes/onedark.sh

#!/bin/sh

# Intel CometLake-U GT2 GPU monitoring for dwmblocks
# Reads legacy i915 per-engine utilization (rcs0)

ENGINE_PATH="/sys/class/drm/card0/engine/rcs0"

BUSY_FILE="$ENGINE_PATH/busy"
AVAIL_FILE="$ENGINE_PATH/available"

if [ ! -f "$BUSY_FILE" ] || [ ! -f "$AVAIL_FILE" ]; then
    echo "GPU: N/A"
    exit 0
fi

# Read first sample
busy1=$(cat "$BUSY_FILE")
avail1=$(cat "$AVAIL_FILE")

# Small delay to measure delta
sleep 0.2

# Read second sample
busy2=$(cat "$BUSY_FILE")
avail2=$(cat "$AVAIL_FILE")

# Compute deltas
busy_delta=$((busy2 - busy1))
avail_delta=$((avail2 - avail1))

# Avoid division by zero
if [ "$avail_delta" -le 0 ]; then
    echo "GPU: 0%"
    exit 0
fi

# Utilization percentage (busy time / available time)
util=$(echo "$busy_delta $avail_delta" | awk '{printf("%.0f", ($1 / $2) * 100)}')

# Comet Lake does not expose GPU power at sysfs → set to N/A
POWER="N/A"

printf "^c#B90E0A^GPU: ${util}%% | ^c#B90E0A^P: ${POWER}"

