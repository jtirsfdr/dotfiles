#status bar script
/home/$USER/.dotfiles/home/.statusbarpc &
#slstatus &

#notification daemon
dunst &

#init sleep after 2 minutes
xautolock -time 3 -locker "~/.dotfiles/home/sleep" -detectsleep &

#disable dummy video card
xrandr --output HDMI-0 --off

#background + colorscheme
wal -i ~/Pictures/Wallpapers/active --saturate 0.3 

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

#Xresources (cursors)
xrdb ~/.Xresources

#vertical screen
#rotleft

#max refresh rate
xlayoutdisplay
#xrandr --dpi 96 --output DP-2 --mode 1920x1080 --rate 240 --pos 0x0 --primary
#echo "Xft.dpi: 96" | xrdb -merge

#activate colorscheme
/home/$USER/.dotfiles/home/walxres

notify-send "Sleep enabled"

#start wm
exec dwm
