#!/bin/bash

# main() is called at last line

h="/home/$1"
user="$1"
#Install yay
#Install programs
#Run xdg-user-dirs
#Copy files
#Enable services
#Hide dotfiles folder
#Change shell
#Warn of TODOS (Go + pipewire)

#Create zsh aliases (separate from program)

main() {
clear
read -p '
Main Menu:

1. Install packages
2. Create user directories
3. Copy config files
4. Toggle dotfiles folder visibility
5. Change shell
6. Do all options with (my) defaults

7. Quit
> '  optsel

case $optsel in
	1)
		clear
		installmenu
		;;
	2)
		createuserdirs
		;;
	3)
		copymenu
		;;
	4)
		togglevisibility
		;;
	5)
		changeshell
		;;
	6)
		rundefaults
		;;
	7 | exit | quit | q)
		exit
		;;
	*)
		echo "invalid"
		main
		;;
esac
}

installmenu() {
read -p '
View | Install package groups: 

0.   | a. yay - AUR Helper (Required)
1.   | b. CLI
2.   | c. Desktop
3.   | d. Fonts + Cursors + Themes
4.   | e. Development
5.   | e. Extra
6.   | f. All

7. Return to menu
> ' optsel

#viewpkg [filename] [header]

clear
case $optsel in
	0)
		echo "yay"
		installmenu
		;;
	1)
		viewpkg "cli"     "### CLI: About 900MB ###"
		;;
	2)
		viewpkg "desktop" "### DESKTOP: About 2GB ###"
		;;
	3)
		viewpkg "font"    "### FONTS: About 3GB ###"
		;;
	4)
		viewpkg "dev"     "### DEVELOPMENT: About 4GB ###"
		;;
	5)
		viewpkg "extra"   "### EXTRA: About 3 GB ###"
		;;
	6)
		viewpkg "all"     "### ALL: About 10 GB ###"
		;;
	a)
		installyay
		;;
	b)
		installpkg "cli"
		;;
	c)
		installpkg
		;;
	d)
		installpkg
		;;
	e)
		installpkg
		;;
	f)
		installpkg
		;;
	7)
		main
		;;
	exit | quit | q)
		exit
		;;
	*)
		echo "Invalid selection"
		installmenu
		;;
esac
}

installpkg(){
	#pacman -Syu
	export envfilename=$PWD/pkg/$1 #
	export envpkgcount=$(wc -l < $envfilename)
	runuser -l $user --whitelist-environment=envfilename,envpkgcount -c 'echo $envpkgcount ; sleep 5s'

#	runuser -l $user --whitelist-environment "$envfilename,$envpkgcount" -c 'cat $filename | tr '\n' ' ' | xargs -n $((pkgcount-1)) yay -S --needed {}'
}

installyay(){
if [ -d "$PWD/yay" ] || [ -f "/usr/bin/yay" ]; then
	echo "yay already installed"
else
	pacman -Syu --needed git base-devel
	sudo -u $user git clone https://aur.archlinux.org/yay.git
	pushd yay
	sudo -u $user makepkg -si
	popd
	echo "yay Installed"
fi

	installmenu
}

viewpkg() {
filename=$PWD/pkg/$1 #internal
header=$2 #internal
longestpkg=$(awk '{if (length > max) { max = length; longest = $0 } } END { print longest }' $filename)
maxlength=$((${#longestpkg} + 4)) # 4 accounts for delimiters and spaces
terminal=/dev/tty
columns=$(stty -a <"$terminal" | grep -Po '(?<=columns )\d+')
entries=$(((columns-4)/maxlength))
pkgcount=$(wc -l < $filename)
frontbuffer=2

echo "
$header
"

#this is slow af but i dont want to reduce time complexity rn
for ((mult = 0; mult <= $((pkgcount / entries)); mult++));
do
	for ((i = 1; i <= entries; i++));
	do
		pkgindex=$((mult * entries))
		pkg=$(sed "$((pkgindex + i))q;d" $filename)
		count=$(echo -n $pkg | wc -m)
		if [ $count != "0" ] ; then
			printf "| %*s" $((frontbuffer))
			printf "%s " $pkg
			printf "%*s" $((maxlength-count-frontbuffer-1))
		fi
	done
	printf "|\n"
done

installmenu

}
: <<'ENDCOMMENT'
#yay -S --needed downgrade \
#bluetuith \
#fbcat \
#informant \
#python-pywal16 \
#zsh-vi-mode 
ENDCOMMENT

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

main
: <<'ENDCOMMENT'

Install yay
Install programs
Run xdg-user-dirs
Copy files
Enable services
Hide dotfiles folder
Change shell
Warn of TODOS (Go + pipewire)

CLI UNSORTED
7zip
acpi
base
base-devel
bat
bluez
bluez-utils
brightnessctl
cowsay
croc
cronie
dnsmasq
duf
dust
fuse
fzf
git
github-cli
imagemagick
lolcat
man-db
man-pages
micro
mpv
mpv
ncdu
neovim
net-tools
openssh 
pipewire
pipewire-alsa
pipewire-pulse
pulsemixer
sl
sof-firmware
strace
timeshift
tlp
tmux
trash-cli
tree
ufw
unp
vi
vim
whois
wireless_tools
yazi
zbar
zellij
zip
eza
xdg-user-dirs
zsh
eza
downgrade
eza
fbcat
fd
gotop
informant
ipcalc
links
lazygit
mc
outfieldr
python-pywal16
sudo
networkmanager
zsh-vi-mode
croc
dnsmasq
fastfetch
greetd 
greetd-tuigreet
swtpm
traceroute
wireplumber
yt-dlp
zoxide
fd

DESKTOP
dwm
st
slstatus 
^^ PATCHED

dragon-drop
dmenu
feh
gimp
keepassxc
kleopatra
nsxiv
picom
rofi
redshift
xdotool
xorg
xournalpp
xsel
xclip
obs-studio
xinit-xsession
xlayoutdisplay
zathura \
timeshift \

WAYLAND
swaqybg
sway
gammastep
foot
wmenu
wofi



FONTS:
gnome-themes-extra
noto-fonts
terminus-font
ttf-liberation-mono-nerd
ttf-noto-nerd
noto-fonts-cjk
ttf-terminus-nerd
adwaita-qt5-git
adwaita-qt6-git
bibata-cursor-theme-bin
lxappearance


DEVELOPMENT:
go
python
godot
odin
raylib
uv
rustup


EXTRA UNSORTED
blender
ollama
qemu-full
virt-manager
syncthing
torbrowser-launcher
localsend
moonlight-qt
wine
wine-gecko
wine-mono


pacman -Syu --needed \
7zip \
acpi \
base-devel \
bat \
blender \
bluez \
bluez-utils \
brightnessctl \
cowsay \
croc \
cronie \
dmenu \
dnsmasq \
duf \
dunst \
dust \
fastfetch \
feh \
fuse \
fzf \
gimp \
git \
github-cli \
gnome-themes-extra \
go \
godot \
greetd \
greetd-tuigreet \
imagemagick \
keepassxc \
kleopatra \
lolcat \
maim \
man-db \
man-pages \
mpv \
ncdu \
neovim \
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
raylib \
redshift \
rofi \
sl \
sof-firmware \
strace \
swaybg \
swtpm \
syncthing \
terminus-font \
timeshift \
tlp \
tmux \
torbrowser-launcher \
traceroute \
trash-cli \
tree \
ttf-liberation-mono-nerd \
ttf-noto-nerd \
ttf-terminus-nerd \
ttf-terminus-nerd \
ufw \
unp \
uv \
virt-manager \
wireplumber \
xdg-user-dirs \
xdotool \
xorg \
xournalpp \
xsel \
yazi \
yt-dlp \
zathura \
zbar \
zoxide \
zsh \

if [ -d "/home/$user/.dotfiles/yay" ] || [ -f "/usr/bin/yay" ]; then
	echo "[WARN]: yay already installed, skipping" >> log
else
	mkdir -p /home/$user/.dotfiles && cd /home/$user/.dotfiles
	sudo -u $user git clone https://aur.archlinux.org/yay.git
	cd yay
	sudo -u $user makepkg -si
	echo "[DONE]: yay installed" >> log
fi

sudo -u $user yay -S --needed \
adwaita-qt5-git \
adwaita-qt6-git \
bibata-cursor-theme-bin \
bluetuith \
downgrade \
dragon-drop \
eza \
fbcat \
fd \
foot \
gammastep \
gotop \
informant \
ipcalc \
lazygit \
links \
localsend \
lxappearance \
lynx \
mc \
megatools \
micro \
moonlight-qt \
net-tools \
noto-fonts-cjk \
obs-studio \
oh-my-posh \
outfieldr \
python-pywal16 \
vi \
vim \
whois \
wine-gecko \
wine-mono \
winetricks \
wireless_tools \
wireshark-qt \
wmenu \
wofi \
xautolock \
xclip \
xcolor \
xinit-xsession \
xlayoutdisplay \
zbar \
zellij \
zip \
zsh-vi-mode \

#Bluetooth controller fix
echo "[WARN]: Performing downgrade on bluetooth library for bluetooth controller support" >> log
sudo downgrade bluez --oldest --ignore always -- --needed

xdg-user-dirs-update

systemctl enable --now tlp
systemctl enable --now cronie

install dwm
install st
install slstatus


#[srcdir] [destdir] [filename] + (auto mkdir)
sudo cp $(pwd)/home/config.toml /etc/greetd/config.toml
sudo cp $(pwd)/home/issue /etc/issue
sudo cp $(pwd)/home/40-libinput.conf /etc/X11/xorg.conf.d/40-libinput.conf
copyfile home/ $h/ .xinitrc
copyfile home/ $h/ .zshrc
copyfile home/ $h/ .Xresources
copyfile home/ $h/ .zprofile
copyfile home/ $h/.config/dunst/ dunstrcmerge
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

go env -w GOPATH=$HOME/.go

echo "### FINISHED ###" >> log
echo "### Run systemctl --user enable --now pipewire-pulse to fix pulsemixer ###" >> log
ENDCOMMENT

