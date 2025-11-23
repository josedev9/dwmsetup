#!/bin/bash
. /home/jose/dwmsetup/suckless/dwmblocks/scripts/themes/onedark.sh
date=$( date '+%b %d (%a) %H:%M')
printf "^c$bgalt^ %s %s \\n" "$date"
