h="/home/$1"
echo "Installing to: $h"

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
nemo \
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
git \
fzf \
cronie \
timeshift \
pipewire \
pipewire-alsa \
pipewire-pulse \
wireplumber \
pulsemixer \
xautolock \
go \
odin \
fuse \
brightnessctl \
keepassxc \
kleopatra \
torbrowser-launcher \
ttf-terminus-nerd \
noto-fonts \
gimp \
github-cli \
gnome-themes-extra \
godot \
imagemagick \
man-db \
man-pages \
neofetch \
nitrogen \
xournalpp \
blender \
ollama \
openssh \
qemu-full \
virt-manager \
raylib \
syncthing \
ttf-liberation-mono-nerd \


if [ -d "/home/$1/.dotfiles/yay" ] || [ -f "/usr/bin/yay" ]; then
	echo "[WARN]: yay already installed, skipping"
else
	mkdir -p /home/$1/.dotfiles && cd /home/$1/.dotfiles
	sudo -u $1 git clone https://aur.archlinux.org/yay.git
	cd yay
	sudo -u $1 makepkg -si
	echo "[DONE]: yay installed"
fi

sudo -u $1 yay -S --needed bluetuith \
downgrade \
oh-my-posh

#Bluetooth controller fix
echo "[WARN]: Performing downgrade on bluetooth library for bluetooth controller support"
sudo downgrade bluez --oldest --ignore always -- --needed

xdg-user-dirs-update

systemctl enable --now tlp
systemctl enable --now cronie

if [ -f /usr/local/bin/dwm ]; then
	echo "[WARN]: dwm already installed, skipping"
else
	pushd $(pwd)/dwm
	make clean install
	popd
	echo "[DONE]: dwm installed"
fi

if [ -f /usr/local/bin/st ]; then
	echo "[WARN]: st already installed, skipping"
else
	pushd $(pwd)/st-flexipatch
	make clean install
	popd
	echo "[DONE]: st installed"
fi

if [ -f /usr/local/bin/dmenu ]; then
	echo "[WARN]: dmenu already installed, skipping"
else
	pushd $(pwd)/dmenu
	make clean install
	popd
	echo "[DONE]: dmenu installed"
fi

sh=$(getent passwd $1 | cut -d: -f7)
if [ $sh == /usr/bin/zsh ]; then
	echo "[WARN]: zsh is current shell, skipping"
else
	chsh -s /usr/bin/zsh $1
	echo "[DONE]: Current shell is zsh"
fi

if [ -f $h/.config/nvim/init.vim ] || [ -f $h/.config/nvim/init.lua ]; then
	echo "[WARN]: init.vim/init.lua already exists, skipping"
else
	sudo -u $1 mkdir -p $h/.config/nvim/
	sudo -u $1 cp $(pwd)/init.vim $h/.config/nvim/init.vim
	sudo -u $1 sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	echo "[DONE]: init.vim copied"
fi

if [ -f $h/.config/picom/shaders/grayscale.glsl ]; then
	echo "[WARN]: Grayscale shader already exists, skipping"
else
	sudo -u $1 mkdir -p $h/.config/picom/shaders/
	sudo -u $1 cp $(pwd)/grayscale.glsl $h/.config/picom/shaders/grayscale.glsl
	echo "[DONE]: Grayscale picom shader copied"
fi

if [ -d $h/Pictures/Wallpapers ]; then
	echo "[WARN]: Wallpapers folder already exists, skipping"
else
	sudo -u $1 mkdir -p $h/Pictures/
	sudo -u $1 cp -r $(pwd)/Wallpapers $h/Pictures/Wallpapers
	echo "[DONE]: Wallpapers folder copied"
fi

if [ -f $h/.xinitrc ]; then
	echo "[WARN]: $h/.xinitrc already exists, backing up original to $h/.xinitrcbu"
	sudo -u $1 cp $h/.xinitrc $h/.xinitrcbu
	sudo -u $1 cp $(pwd)/.xinitrc $h/.xinitrc
else
	sudo -u $1 cp $(pwd)/.xinitrc $h/.xinitrc
	echo "[DONE]: $h/.xinitrc copied" 
fi

if [ -f $h/.zshrc ]; then
	echo "[WARN]: $h/.zshrc already exists, backing up original to $h/.zshrcbu"
	sudo -u $1 cp $h/.zshrc $h/.zshrcbu
	sudo -u $1 cp $(pwd)/.zshrc $h/.zshrc
else
	sudo -u $1 cp $(pwd)/.zshrc $h/.zshrc
	echo "[DONE]: $h/.zshrc copied"
fi

if [ -f $h/.Xresources ]; then
	echo "[WARN]: $h/.Xresources already exists, backing up original to $h/.Xresourcesbu"
	sudo -u $1 cp $h/.Xresources $h/.Xresourcesbu
	sudo -u $1 cp $(pwd)/.Xresources $h/.Xresources
else
	sudo -u $1 cp $(pwd)/.Xresources $h/.Xresources
	echo "[DONE]: $h/.Xresources copied"
fi

if [ -d $h/dotfiles ]; then
	sudo -u $1 mv $h/dotfiles $h/.dotfiles
	echo "[DONE]: Dotfiles directory is now hidden ($h/.dotfiles)"
fi


echo "### FINISHED ###"
echo "### Run systemctl --user enable --now pipewire-pulse to fix pulsemixer ###"
