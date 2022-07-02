cd ~/

killall mpd
mpd &
mpDris2 &
sxhkd &
nm-applet &
dwmblocks &
xwallpaper --zoom pictures/wallpapers/1646458962795.jpg

xrandr --dpi 96

bash ~/.local/bin/display-switcher.sh

exec dwm
