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

#environment variables
export EDITOR=nvim
export CROC_SECRET="superfooder"

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
eval "$(oh-my-posh init zsh --config ~/.dotfiles/oh-my-posh/probua.minimal.omp.json)"

# fallback
autoload -Uz promptinit
promptinit
prompt redhat

