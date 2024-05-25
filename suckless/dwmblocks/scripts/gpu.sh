#!/bin/bash
. ~/dwmsetup/suckless/dwmblocks/scripts/themes/onedark.sh
case $BUTTON in
	1) setsid -f "$TERMINAL" -e nvtop ;;
esac

status=$( nvidia-smi | grep "Default" | awk '{print $13}' )
printf "^c$orange^  GPU: ${status}%"
