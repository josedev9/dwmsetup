feh --bg-scale ~/Downloads/wp2132716-pepe-the-frog-wallpapers.jpg &
xrandr --output DP-0 --mode 3840x2160 --rate 165 --scale 1 &
xrdb -merge /home/joser/.Xresources &
picom -b &
setxkbmap -layout us,es -option grp:win_space_toggle &
/usr/local/bin/dwmblocks &
exec dwm
