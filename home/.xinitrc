#status bar script
~/.dotfiles/home/.statusbar &

#init sleep after 2 minutes
xautolock -time 2 -locker "systemctl suspend" -detectsleep &

#disable sleep 
xautolock disable &

#enable grayscale
#picom --backend glx --window-shader-fg /home/sfdr/.config/picom/shaders/grayscale.glsl &

#enable red filter
redshift -O 2300

#set wallpaper
#nitrogen --random --set-zoom-fill ~/Pictures/Wallpapers/active &

#Xresources (cursors)
xrdb ~/.Xresources

#start wm
exec dwm
