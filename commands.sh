#!/bin/bash

# main() is called at last line

h="/home/$1"
user="$1"

main() {

read -p '
Main Menu:
1. View package groups
2. Set package groups
3. Install
4. Quit
> '  optsel
case $optsel in
	1)
		viewmenu
		;;
	2)
		setmenu
		;;
	3)
		installmenu
		;;
	4)
		exit
		;;
	*)
		echo "invalid"
		main
		;;
esac
}

viewpkg() {

read -p '
View package groups:
1. CLI
2. Desktop
3. Fonts + Cursors + Themes
4. Development
5. Extra
6. Return to menu
> ' optsel

#viewpkg [pkgfilename] [header]

case $optsel in
	1)
		viewpkg
		viewmenu "cli" "CLI: About 800MB"
		;;
	2)
		echo "Desktop"
		viewdesktoppkg
		;;
	3)
		echo "Fonts + Cursors"
		;;
	4)
		echo "Development"
		;;
	5)
		echo "Extra"
		;;
	6)
		main
		;;
	*)
		echo "Invalid selection"
		viewpkg
		;;
esac

}
viewdesktoppkg() {
	awktest=$(awk '{if (length > max) { max = length; longest = $0 } } END { print longest }' /home/sfdr/dotfiles/cli)
	printf "%s\n" $awktest
}
view() {
longestpkg=$(awk '{if (length > max) { max = length; longest = $0 } } END { print longest }' /home/sfdr/dotfiles/cli)
maxlength=$((${#longestpkg} + 3)) #3 accounts for 2 delimiters + at least 1 space
terminal=/dev/pts/1
columns=$(stty -a <"$terminal" | grep -Po '(?<=columns )\d+')
newline=$((columns/maxlength))
lines=$(wc -l < /home/sfdr/dotfiles/cli)
echo "$1"

#cover case where maxlength>columns !!!
#this is slow af but i dont want to reduce time complexity rn
for ((mult = 0; mult <= $((lines / newline)); mult++));
do
	for ((i = 1; i <= newline; i++));
	do
		pkgindex=$((mult * newline))
		pkg=$(sed "$((pkgindex + i))q;d" /home/sfdr/dotfiles/cli)
		printf "| %s " $pkg
		count=$(echo -n $pkg | wc -m)
		printf "%*s" $((maxlength-count))
	done
	printf "\n"
done

: <<'ENDCOMMENT'
sudo pacman -Syu \
7zip \
acpi \
base \
base-devel \
bat \
bluez \
bluez-utils \
brightnessctl \
cowsay \
croc \
cronie \
dnsmasq \
duf \
dust \
eza \
fastfetch \
fd \
fuse \
fzf \
git \
github-cli \
greetd  \
greetd-tuigreet \
imagemagick \
ipcalc \
lazygit \
links \
lolcat \
man-db \
man-pages \
mc \
micro \
mpv \
ncdu \
neovim \
net-tools \
networkmanager \
openssh  \
pipewire \
pipewire-alsa \
pipewire-pulse \
pulsemixer \
sl \
sof-firmware \
strace \
sudo \
swtpm \
tlp \
tmux \
traceroute \
trash-cli \
tree \
ufw \
unp \
vi \
vim \
whois \
wireless_tools \
wireplumber \
xdg-user-dirs \
yazi \
yt-dlp \
zbar \
zellij \
zip \
zoxide \
zsh \

#yay -S --needed downgrade \
#bluetuith \
#fbcat \
#informant \
#gotop \
#outfieldr \
#python-pywal16 \
#zsh-vi-mode 
ENDCOMMENT
}

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

