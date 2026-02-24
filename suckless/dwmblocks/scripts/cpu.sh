# top -bn 1 | awk '/^%Cpu/ { print int($2 + $4 + $6)" %"}'
. ~/dwmsetup/suckless/dwmblocks/scripts/themes/onedark.sh
#!/bin/sh

CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/cpu_usage"
mkdir -p "$(dirname "$CACHE")"

# Read current CPU stats
read cpu user nice system idle iowait irq softirq steal guest < /proc/stat

idle_now=$((idle + iowait))
total_now=$((user + nice + system + idle + iowait + irq + softirq + steal))

# If previous stats exist, compute usage
if [ -f "$CACHE" ]; then
    read prev_idle prev_total < "$CACHE"

    diff_idle=$((idle_now - prev_idle))
    diff_total=$((total_now - prev_total))

    if [ "$diff_total" -gt 0 ]; then
        usage=$((100 * (diff_total - diff_idle) / diff_total))
    else
        usage=0
    fi
else
    usage=0
fi

# Store current stats
echo "$idle_now $total_now" > "$CACHE"

#printf "^c$cyan^CPU: %d%%\n" "$usage"
printf "^c$cyan^ CPU: $usage %%" "$usage"
