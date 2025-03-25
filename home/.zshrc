# ZSH preconfiguration
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -e
zstyle :compinstall filename '/home/sfdr/.zshrc'
autoload -Uz compinit
compinit


## MISC
# Path
export PATH=/home/sfdr/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/lib/rustup/bin

# Aliases
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
alias rm='echo "Use trash or \\\rm"'
alias copy='xsel -b -i'
alias gotop='gotop -c monokai'
alias grayscale='picom --backend glx --window-shader-fg /home/sfdr/.config/picom/shaders/grayscale.glsl &'
alias maimreg='ls "$SSDIR" -A | wc -l | read -r FC && maim -s | tee "$SSDIR/ss_$FC.png" | xclip -selection clipboard -t image/png'
alias maimfs='ls "$SSDIR" -A | wc -l | read -r FC && maim "$SSDIR/ss_$FC"'
alias maimmega='megatools ls --reload --names "/Root/Screenshots" | wc -l | read -r FC ; maim -s | tee "$SSDIR/ssm_$FC.png" ; megatools put "$SSDIR/ssm_$FC.png" --path "/Root/Screenshots/ssm_$FC.png" ; megatools export --reload "/Root/Screenshots/ssm_$FC.png" | xclip -selection clipboard'
alias qr='maim -qs | zbarimg -q --raw - | xclip -selection clipboard -f'
alias rotleft='xrandr -o left'
alias rotnormal='xrandr -o normal'
alias rotright='xrandr -o right'

## ENVIRONMENT VARIABLES 
export EDITOR=nvim
export CROC_SECRET="superfooder"
export SSDIR="/home/$USER/Pictures/Screenshots"

#dark mode
export GTK_THEME=Adwaita:dark
export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
export QT_STYLE_OVERRIDE=Adwaita-Dark


## PROGRAMS 
# zoxide
if [ -f /usr/bin/zoxide ]; then
	eval "$(zoxide init zsh)"
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
eval "$(oh-my-posh init zsh --config ~/.dotfiles/themes/probua.minimal.omp.json)"

# fallback
autoload -Uz promptinit
promptinit
prompt redhat
