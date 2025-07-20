#gocryptfs
#gocryptfs [encrypted dir] [mountdir]
#fusermount -u [mountdir]
#xrdb -merge ~/.Xresources

# ZSH preconfiguration
unsetopt beep
bindkey -e
zstyle :compinstall filename '/home/$USER/.zshrc'
#zstyle :compinstall '/home/$USER/.zshrc'
# allows calling environment variables in PROMPT
setopt prompt_subst
autoload -U colors && colors
autoload -Uz compinit
autoload -Uz vcs_info
precmd () { vcs_info }
zstyle ':vcs_info:*' formats '- %s(%b) %u %c %a'
compinit

xset r rate 250 35

# libreoffice theming but breaks 
#SAL_USE_VCLPLUGIN=gtk4
# legacy theming
SAL_USE_VCLPLUGIN=gen

## MISC
# Path
export PATH="$PATH":/home/$USER/files/bin
export PATH="$PATH":/home/$USER/.local/bin
export PATH="$PATH":/usr/local/sbin
export PATH="$PATH":/usr/local/bin
export PATH="$PATH":/usr/bin:/usr/bin/site_perl
export PATH="$PATH":/usr/bin/vendor_perl
export PATH="$PATH":/usr/bin/core_perl
export PATH="$PATH":/usr/lib/rustup/bin
export PATH="$PATH":/opt/flutter/bin
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$PATH":"$HOME/.dotfiles/home"

# Alias
alias t="tldr"
alias have="pacman -Q | grep"
alias man="man -P 'less -j5'"
alias red='redshift -P -O 3500 -g 1'
alias gamma='redshift -P -O 6500 -g'
alias less='less -j5'
alias dl='yay -S --noconfirm'
alias ipv4='ip -o -4 addr'
alias 4k60='xrandr --output HDMI-1 --mode 4096x2160 --rate 60 --scale 4x4 --dpi 386 --output eDP-1 --off ' #add xft dpi thing
alias 1080120='xrandr --output HDMI-1 --mode 1920x1080 --rate 120 --scale 2x2 --dpi 192 --output eDP-1 --off'
alias serialnum='dmidecode -s system-serial-number'
alias lg='lazygit'
alias smci='sudo make clean install'
alias drag='dragon-drop'
alias nmclidhcp='for con in $(nmcli -g NAME con show --active | grep -v 'lo') ; do echo "Connection $con" ; nmcli -t -f DHCP4 con show "$con" ; echo ; done'
alias soundtest='mpv /home/$USER/Music/Sounds/cat.mp3'
alias vencord='sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"'
alias webcam='gst-launch-1.0 v4l2src device=/dev/video0 ! xvimagesink'
alias sink='rsync -avP' #src dest
alias xpp='xournalpp ~/files/xournalpp/default.xopp'
#alias nwp='wal -i ~/Pictures/Wallpapers/active --saturate 0.3 ; /home/$USER/.dotfiles/home/walxres' 
alias nwp='wal -i ~/Pictures/Wallpapers/active --saturate 0.3 -n; feh --bg-fill "$(< "/home/$USER/.cache/wal/wal")" ; /home/$USER/.dotfiles/home/walxres'
#alias npw='wal -i ~/Pictures/Wallpapers/active --saturate 0.3 ; /home/$USER/.dotfiles/home/walxres'  
alias uefireboot='sudo grub-reboot "2" && reboot'
alias pac='sudo pacman -Syu'
alias xsleep='xautolock -locker "systemctl suspend" -detectsleep'
alias son="brightnessctl set 100"
alias soff="brightnessctl set 0"
alias bs="brightnessctl set"
alias battery="cat /sys/class/power_supply/BAT0/capacity"
alias batterystatus="cat /sys/class/power_supply/BAT0/status"
alias ls="ls --color=auto"
alias vim="nvim"
alias grep="grep --color=auto"
alias sudo="sudo "
#alias rm='echo "Use trash or \\\rm"'
alias copy='xsel -b -i'
alias gotop='gotop -c monokai'
alias grayscale='picom --backend glx --window-shader-fg /home/$USER/.config/picom/shaders/grayscale.glsl &'
#alias maimreg='ls "$SSDIR" -A | wc -l | read -r FC ; maim -s | tee "$SSDIR/ss_$FC.png" | xclip -selection clipboard -t image/png'
alias maimreg='ls "$SSDIR" -A | wc -l | read -r FC && maim -f png -s "$SSDIR/ss_$FC.png"'
alias maimfs='ls "$SSDIR" -A | wc -l | read -r FC && maim "$SSDIR/ss_$FC"'
alias maimmega='megatools ls --reload --names "/Root/Screenshots" | wc -l | read -r FC ; maim -s | tee "$SSDIR/ssm_$FC.png" ; megatools put "$SSDIR/ssm_$FC.png" --path "/Root/Screenshots/ssm_$FC.png" ; megatools export --reload "/Root/Screenshots/ssm_$FC.png" | xclip -selection clipboard'
alias qr='maim -qs | zbarimg -q --raw - | xclip -selection clipboard -f'
alias rotleft='xrandr -o left'
alias rotnormal='xrandr -o normal'
alias rotright='xrandr -o right'

## ENVIRONMENT VARIABLES 
export EDITOR=nvim
#export CROC_SECRET="superfooder"
export SSDIR="/home/$USER/Pictures/Screenshots"

#dark mode
#export GTK_THEME=Adwaita:dark
#export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
#export QT_STYLE_OVERRIDE=Adwaita-Dark


## PROGRAMS 
# zoxide
if [ -f /usr/bin/zoxide ]; then
	eval "$(zoxide init --hook prompt zsh)"
fi

# yazi
if [ -f /usr/bin/yazi ]; then
	function y() {
		local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
		yazi "$@" --cwd-file="$tmp"
		if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
			builtin cd -- "$cwd"
		fi
		rm -f -- "$tmp"
	}
fi

## THEMES
# oh my posh
#eval "$(oh-my-posh init zsh --config ~/.dotfiles/oh-my-posh/probua.minimal.omp.json)"

# gitless transient prompt 98
#export PS1='${vcs_info_msg_0_}%# '
export PS1='%F{183}%n@%m%f %F{180}%/ ${vcs_info_msg_0_}
>%f '

# fallback
#autoload -Uz promptinit
#promptinit
#prompt redhat

source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
# [[ -f /home/sfdr/.dart-cli-completion/zsh-config.zsh ]] && . /home/sfdr/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

# st run command on launch
#if [[ $1 == eval ]]
#then
#	"$@"
#set --
#fi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
