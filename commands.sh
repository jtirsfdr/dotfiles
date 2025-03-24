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
oh-my-posh \
gotop

#Bluetooth controller fix
echo "[WARN]: Performing downgrade on bluetooth library for bluetooth controller support"
sudo downgrade bluez --oldest --ignore always -- --needed

xdg-user-dirs-update

systemctl enable --now tlp
systemctl enable --now cronie

install() {
if [ -f /usr/local/bin/$1 ]; then
	echo "[WARN]: $1 already installed, skipping"
else
	pushd $(pwd)/$1
	make clean install
	popd
	echo "[DONE]: $1 installed"
fi
}

copyfile() {
if [ -f $h/$1 ]; then
	echo "[WARN]: $h/$1 already exists, creating backup at $h/$1~"
	sudo -u $1 cp --backup $(pwd)/home/$1 $h/$1
else
	sudo -u $1 cp $(pwd)/home/$1 $h/$1
	echo "[DONE]: $h/$1 copied" 
fi
}

install dwm
install st
install dmenu

copyfile .xinitrc
copyfile .zshrc
copyfile .Xresources

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
	sudo -u $1 cp $(pwd)/nvim/init.vim $h/.config/nvim/init.vim
	sudo -u $1 sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	echo "[DONE]: init.vim copied"
fi

if [ -f $h/.config/picom/shaders/grayscale.glsl ]; then
	echo "[WARN]: Grayscale shader already exists, skipping"
else
	sudo -u $1 mkdir -p $h/.config/picom/shaders/
	sudo -u $1 cp $(pwd)/picom/grayscale.glsl $h/.config/picom/shaders/grayscale.glsl
	echo "[DONE]: Grayscale picom shader copied"
fi

if [ -f $h/.config/picom/picom.conf ]; then
	echo "[WARN]: Picom configuration file already exists, skipping"
else
	sudo -u $1 mkdir -p $h/.config/picom/
	sudo cp $(pwd)/picom/picom.conf $h/.config/picom/picom.conf
	sudo chmod a+rw $h/.config/picom/picom.conf
	echo "[DONE]: Picom configuration file copied"
fi

if [ -d $h/Pictures/Wallpapers ]; then
	echo "[WARN]: Wallpapers folder already exists, skipping"
else
	sudo -u $1 mkdir -p $h/Pictures/
	sudo -u $1 cp -r $(pwd)/Wallpapers $h/Pictures/Wallpapers
	echo "[DONE]: Wallpapers folder copied"
fi


if [ -d $h/.config/yazi ]; then
	echo "[WARN]: yazi folder exists, existing configs will be backed up"
fi

sudo -u $1 ya pack -a yazi-rs/plugins:toggle-pane
sudo -u $1 ya pack -a yazi-rs/plugins:git
sudo -u $1 ya pack -a yazi-rs/plugins:full-border
sudo -u $1 ya pack -a yazi-rs/plugins:smart-filter
sudo -u $1 ya pack -a yazi-rs/plugins:smart-enter
sudo -u $1 ya pack -a yazi-rs/plugins:jump-to-char
sudo -u $1 ya pack -a dangooddd/kanagawa
sudo -u $1 ya pack -a bennyyip/gruvbox-dark

sudo -u $1 cp $(pwd)/yazi/package.toml $h/.config/yazi/package.toml
sudo -u $1 cp $(pwd)/yazi/keymap.toml $h/.config/yazi/keymap.toml
sudo -u $1 cp $(pwd)/yazi/theme.toml $h/.config/yazi/theme.toml 
sudo -u $1 cp $(pwd)/yazi/yazi.toml $h/.config/yazi/yazi.toml 
sudo -u $1 cp $(pwd)/yazi/init.lua $h/.config/yazi/init.lua

if [ -d $h/dotfiles ]; then
	sudo -u $1 mv $h/dotfiles $h/.dotfiles
	echo "[DONE]: Dotfiles directory is now hidden ($h/.dotfiles)"
fi

echo "### FINISHED ###"
echo "### Run systemctl --user enable --now pipewire-pulse to fix pulsemixer ###"
