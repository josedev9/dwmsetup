#!/bin/bash
# Dependencies: NetworkManager, NetworkManager-openvpn (for OpenVPN connections)
IDENTIFIER="unicode"
. ~/dwmsetup/suckless/dwmblocks/scripts/themes/onedark.sh
printer() {
    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
        printf "^c%s^ 🔒 %s\n" "$COLOR" "$VPN1"
    else
        printf "^c%s^VPN %s" "$COLOR" "$VPN1"
    fi
    printf "%s\n" "$SEP2"

}
dwm_vpn() {
    VPN=$(nmcli c | grep 'wireguard' | awk '{ printf $4 }')
    VPN1=$(nmcli c | grep 'wireguard' | awk '{ printf $1 }')
    if [ "$VPN1" == "" ]; then
        VPN1="DEFAULT"
    fi
    if [ "$VPN" == "" ] || [ "$VPN" == "--" ]; then
        COLOR=#ff6c6b
        printer
    else
        COLOR=#98be65
        printer
    fi
    printf "%s\n" "$SEP2"
}

dwm_vpn
