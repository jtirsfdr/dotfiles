h="/home/$1"
user="$1"
echo "Installing to: $h" >> log

install() {
if [ -f /usr/local/bin/$1 ]; then
	echo "[WARN]: $1 already installed, skipping" >> log
else
	pushd $(pwd)/$1
	make clean install
	popd
	echo "[DONE]: $1 installed" >> log
fi
}

copyfile() {
# $1 = /home/.dotfiles/[srcdir]
# $2 = [destdir]
# $3 = [file]
if [ -f $2$3 ]; then
	echo "[WARN]: $3 already exists, creating backup at $3~" >> log
	sudo -u $user cp --backup $(pwd)/$1$3 $2$3
else
	sudo -u $user mkdir -p $2
	sudo -u $user cp --backup $(pwd)/$1$3 $2$3
	echo "[DONE]: $h/$user copied" >> log
fi
}

pacman -Syu --needed neovim \
7zip \
acpi \
base-devel \
blender \
brightnessctl \
croc \
cronie \
fuse \
fzf \
gimp \
git \
git \
github-cli \
gnome-themes-extra \
go \
godot \
imagemagick \
keepassxc \
kleopatra \
man-db \
man-pages \
mpv \
ncdu \
nemo \
nitrogen \
noto-fonts \
nsxiv \
odin \
ollama \
openssh \
openssh \
picom \
pipewire \
pipewire-alsa \
pipewire-pulse \
pulsemixer \
qemu-full \
raylib \
redshift \
syncthing \
timeshift \
tlp \
tmux \
torbrowser-launcher \
trash-cli \
ttf-liberation-mono-nerd \
ttf-terminus-nerd \
virt-manager \
wireplumber \
xdg-user-dirs \
xorg \
xournalpp \
xsel \
yazi \
yt-dlp \
zathura \
zoxide \
zsh \
maim \
zbar \
ttf-terminus-nerd \
terminus-font \
dunst \
dmenu \
xdotool \

if [ -d "/home/$user/.dotfiles/yay" ] || [ -f "/usr/bin/yay" ]; then
	echo "[WARN]: yay already installed, skipping" >> log
else
	mkdir -p /home/$user/.dotfiles && cd /home/$user/.dotfiles
	sudo -u $user git clone https://aur.archlinux.org/yay.git
	cd yay
	sudo -u $user makepkg -si
	echo "[DONE]: yay installed" >> log
fi

sudo -u $user yay -S --needed bluetuith \
downgrade \
oh-my-posh \
gotop \
bibata-cursor-theme-bin \
zsh-vi-mode \
megatools \
xautolock \
neofetch \
python-pywal16

#Bluetooth controller fix
echo "[WARN]: Performing downgrade on bluetooth library for bluetooth controller support" >> log
sudo downgrade bluez --oldest --ignore always -- --needed

xdg-user-dirs-update

systemctl enable --now tlp
systemctl enable --now cronie

install dwm
install st
#install dmenu

#[srcdir] [destdir] [filename] + (auto mkdir)
copyfile home/ $h/ .xinitrc
copyfile home/ $h/ .zshrc
copyfile home/ $h/ .Xresources
copyfile home/ $h/ .zprofile
copyfile home/ $h/.config/dunst
copyfile vim/ $h/.config/nvim/ init.vim
copyfile picom/ $h/.config/picom/ picom.conf
copyfile picom/ $h/.config/picom/shaders/ grayscale.glsl
copyfile nvim/ $h/.config/nvim/ init.vim

#make picom.conf modifiable
sudo chmod a+rw $h/.config/picom/picom.conf

#vim-plug
sudo -u $user sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'


sh=$(getent passwd $user | cut -d: -f7)
if [ $sh == /usr/bin/zsh ]; then
	echo "[WARN]: zsh is current shell, skipping" >> log
else
	chsh -s /usr/bin/zsh $user
	echo "[DONE]: Current shell is zsh" >> log
fi

sudo -u $user mkdir -p $h/Pictures/Screenshots
if [ -d $h/Pictures/Wallpapers ]; then
	echo "[WARN]: Wallpapers folder already exists, skipping" >> log
else
	sudo -u $user cp -r $(pwd)/Wallpapers $h/Pictures/Wallpapers
	echo "[DONE]: Wallpapers folder copied" >> log
fi


if [ -d $h/.config/yazi ]; then
	echo "[WARN]: yazi folder exists, existing configs will be backed up" >> log
fi

sudo -u $user ya pkg add yazi-rs/plugins:toggle-pane
sudo -u $user ya pkg add yazi-rs/plugins:git
sudo -u $user ya pkg add yazi-rs/plugins:full-border
sudo -u $user ya pkg add yazi-rs/plugins:smart-filter
sudo -u $user ya pkg add yazi-rs/plugins:smart-enter
sudo -u $user ya pkg add yazi-rs/plugins:jump-to-char
sudo -u $user ya pkg add dangooddd/kanagawa
sudo -u $user ya pkg add bennyyip/gruvbox-dark

sudo -u $user cp $(pwd)/yazi/package.toml $h/.config/yazi/package.toml
sudo -u $user cp $(pwd)/yazi/keymap.toml $h/.config/yazi/keymap.toml
sudo -u $user cp $(pwd)/yazi/theme.toml $h/.config/yazi/theme.toml 
sudo -u $user cp $(pwd)/yazi/yazi.toml $h/.config/yazi/yazi.toml 
sudo -u $user cp $(pwd)/yazi/init.lua $h/.config/yazi/init.lua

if [ -d $h/dotfiles ]; then
	sudo -u $user mv $h/dotfiles $h/.dotfiles
	echo "[DONE]: Dotfiles directory is now hidden ($h/.dotfiles)" >> log
fi

echo "### FINISHED ###" >> log
echo "### Run systemctl --user enable --now pipewire-pulse to fix pulsemixer ###" >> log
