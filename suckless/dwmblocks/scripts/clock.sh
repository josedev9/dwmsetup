#!/bin/bash
. ~/.suckless/dwmblocks/scripts/themes/onedark.sh
date=$( date '+%b %d (%a) %H:%M')
printf "^c$bgalt^ %s %s \\n" "$date"
