#status bar script
#/home/$USER/.dotfiles/home/.statusbarpc &
slstatus &

#notification daemon
dunst &

#reduce time to repeat keys while holding
xset r rate 200 35

#init sleep after 2 minutes
xautolock -time 3 -locker "~/.dotfiles/home/sleep" -detectsleep &

#disable dummy video card
#xrandr --output HDMI-0 --off

#background + colorscheme
wal -i /home/$USER/Pictures/Wallpapers/active --saturate 0.3 &

#set wallpaper (no colorscheme)
#nitrogen --random --set-zoom-fill ~/Pictures/Wallpapers/active &

#disable sleep 
#xautolock -disable &
#echo " Sleep Off | " > /home/sfdr/.dotfiles/home/slp 

#enable sleep
xautolock -enable &
echo " Sleep On | " > /home/$USER/.dotfiles/home/slp

#enable compositor (transparency, but adds input lag)
#picom &

#enable grayscale
#picom --backend glx --window-shader-fg /home/sfdr/.config/picom/shaders/grayscale.glsl &

#enable red filter
#redshift -O 2300
redshift -O 3500

#Xresources (cursors)
xrdb ~/.Xresources

#vertical screen
#rotleft

#max refresh rate {num}x96 works best
xlayoutdisplay
#xrandr --dpi 72 --output eDP-1 --mode 1366x768 --pos 0x0 --primary
#echo "Xft.dpi: 72" | xrdb -merge

#activate colorscheme
/home/$USER/.dotfiles/home/walxres &

#max brightness
#brightnessctl set 100%

#notify-send -t 10000 "Sleep enabled"  
#notify-send -t 10000 "Press Alt+Shift+Q to exit" 

#start wm
exec dwm


