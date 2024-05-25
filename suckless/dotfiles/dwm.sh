feh --bg-scale ~/Downloads/wp2132716-pepe-the-frog-wallpapers.jpg &
xrandr --output DP-0 --auto &
xrdb -merge /home/joser/.Xresources &
picom -b &
setxkbmap -layout us,es -option grp:win_space_toggle &
/usr/local/bin/dwmblocks &
exec dwm
