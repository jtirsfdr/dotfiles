if [ $1 ]; then
	continue
else
	echo "Please pass the user to install for as a parameter"
	echo "eg: $ sudo ./download.sh bob"
	exit
fi

pacman -Syu --needed neovim \
picom \
git \
xorg \
base-devel \
mpv \
ncdu \
zoxide \
yazi \
yt-dlp \
thunar \
redshift \
zsh \
acpi \
tmux \
zathura \
xsel \
xdg-user-dirs \
tlp \
7zip \
trash-cli \
nsxiv \
croc \
openssh \
quilt \
git \
fzf \
cronie \
timeshift \

if [ -d "/home/$1/.dotfiles/yay" ] || [ -f "/usr/bin/yay" ]; then
	echo "yay already installed"
else
	echo "cloning yay"
	mkdir -p /home/$1/.dotfiles && cd /home/$1/.dotfiles
	sudo -u $1 git clone https://aur.archlinux.org/yay.git
	cd yay
	sudo -u $1 makepkg -si
	echo "run "makepkg -si" in /home/$1/.dotfiles/yay/"
fi

if [ -f "/home/$1/bin/oh-my-posh" ] || [ -f "/home/$1/.local/bin/oh-my-posh" ]; then
	sudo -u $1 curl -s https://ohmyposh.dev/install.sh | bash -s
fi

sudo -u $1 yay -S --needed bluetuith-bin \
downgrade 

echo "Make sure you downgrade bluez to 5.68 or lower for controller support"
echo "$ downgrade bluez"
