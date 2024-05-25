. ~/dwmsetup/suckless/dwmblocks/scripts/themes/onedark.sh
dwm_pulse () {
    VOL=$(pamixer --get-volume)
    STATE=$(pamixer --get-mute)
    IDENTIFIER="unicode" 
    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
        if [ "$STATE" = "true" ] || [ "$VOL" -eq 0 ]; then
            printf "^c$yellow^ MUTED"
        elif [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
            printf "^c$yellow^ %s%%" "$VOL"
        # elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
        #     printf "^c$yellow^🔉 %s%%" "$VOL"
        else
            printf "^c$yellow^ %s%%" "$VOL"
        fi
    else
        if [ "$STATE" = "true" ] || [ "$VOL" -eq 0 ]; then
            printf "^c$yellow^MUTED"
        elif [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
            printf "^c$yellow^VOL %s%%" "$VOL"
        elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
            printf "^c$yellow^VOL %s%%" "$VOL"
        else
            printf "^c$yellow^VOL %s%%" "$VOL"
        fi
    fi
    printf "%s\n" "$SEP2"
}

dwm_pulse
