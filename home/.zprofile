source "/home/sfdr/code/emsdk/emsdk_env.sh"

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec startx
fi

