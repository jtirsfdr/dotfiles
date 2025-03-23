pacman -Syu --needed neovim \
picom \
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
nitrogen \
qemu \
virt-manager \
firefox \
calibre \

if [ -d "~/.bin/yay" || -f "/usr/bin/yay" ]; then
	echo "installing yay"
	mkdir -p ~/.bin && cd ~/.bin
	git clone https;//aur.archlinux.org/yay.git
	cd yay
	sudo -u "$USER" makepkg -si
else
	echo "yay already installed"
fi

if [ -f "~/bin/oh-my-posh" || -f "~/.local/bin/oh-my-posh" ]; then
	curl -s https://ohmyposh.dev/install.sh | bash -s
fi

sudo -u $USER yay -S --needed bluetuith-bin \
downgrade \
moonlight-qt-bin \
sunshine-bin \
anki-bin \

echo "Make sure you downgrade bluez to 5.68 or lower for controller support"
