#!/bin/bash

# main() is called at last line

h="/home/$1"
user="$1"
running=true

TODO
#Copy files
#Hide dotfiles folder
#Change shell
#Warn of TODOS (Go + pipewire)
#Drivers install
#Suckless install

#Create zsh aliases (separate from program)

clear

main() {
	while [ $running = true ] ; 
do
	mainmenu
done
}

mainmenu() {
	read -p \
'
Main Menu:


0. Setup environment with defaults

1. Install packages
2. Create user directories
3. Downgrade bluez (controller fix)
4. Enable tlp, cronie, & ntp services
5. Copy config files
6. Toggle dotfiles folder visibility
7. Change shell

8. Quit
> '  optsel

	clear
	case $optsel in
		0)
			rundefaults
			;;
		1)
			installmenu
			;;
		2)
			createuserdirs
			;;
		3)
			downgradebluez
			;;
		4)
			enableservices
			;;
		5)
			copymenu
			;;
		6)
			togglevisibility
			;;
		7)
			changeshell
			;;
		8 | exit | quit | q)
			exit
			;;
		*)
			echo "invalid input"
			;;
	esac
}

copymenu() {
	echo \
"Select mode:
1. Backup existing files, then copy
2. Force replace existing files
3. Skip if file exists
Select files:
" 
# Show all files recursively
# I will do this tomorrow

}
downgradebluez() {
	sudo downgrade bluez bluez-utils --oldest --ignore always -- --needed
	clear
	echo \
"bluez & bluez-utils downgraded to oldest available version.
This isn't recommended. Consider manually running downgrade
and switching to version 5.68
---"
}

installmenu() {
read -p '
View | Install package groups: 

0.   | a. yay - AUR Helper (Required)
1.   | b. CLI
2.   | c. Desktop
3.   | d. Fonts + Cursors + Themes
4.   | e. Development
5.   | f. Extra
6.   | g. All

7. Return to menu
> ' optsel

#viewpkg [filename] [header]

clear
case $optsel in
	0)
		viewyay
		;;
	1)
		viewpkg "cli"     "### CLI: About 800MB ###"

		;;
	2)
		viewpkg "desktop" "### DESKTOP: About 1.2GB ###"
		;;
	3)
		viewpkg "font"    "### FONTS: About 2GB ###"
		;;
	4)
		viewpkg "dev"     "### DEVELOPMENT: About 700MB ###"
		;;
	5)
		viewpkg "extra"   "### EXTRA: About 4 GB ###"
		;;
	6)
		viewpkg "all"     "### ALL: About 10 GB ###"
		;;
	a)
		installyay
		;;
	b)
		sudo -u $user sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

		installpkg "cli"
		;;
	c)
		installpkg "desktop"
		installsuckless
		;;
	d)
		installpkg "font"
		;;
	e)
		installpkg "dev"
		;;
	f)
		installpkg "extra"
		;;
	g)
		installpkg "all"
		;;
	7)
		return
		;;
	exit | quit | q)
		exit
		;;
	*)
		echo "Invalid selection"
		installmenu
		;;
esac

installmenu

}

viewyay() {
	echo "yay" #add ascii
	echo "---"
}

enableservices() {
	systemctl enable --now tlp
	systemctl enable --now cronie
	systemctl enable --now systemd-timesyncd
	systemctl enable greetd
	echo \
"greetd will start on reboot.
Make sure you enable pipewire-pulse manually.
> systemctl --user enable --now pipewire-pulse
---"
}

installsuckless() { #IMPLEMENT!!!
#for each argument
#run installer 
	if [ -f /usr/local/bin/$1 ]; then
		echo "[WARN]: $1 already installed, skipping" >> log
	else
		pushd $(pwd)/$1
		make clean install
		popd
		echo "[DONE]: $1 installed" >> log
	fi
}

installpkg(){
	export envfilename=$PWD/pkg/$1 #
	export envpkgcount=$(wc -l < $envfilename)
	
	pacman -Syu

	runuser -P -l $user --whitelist-environment=envfilename,envpkgcount -c 'xargs < $envfilename -n $envpkgcount yay -S --noconfirm --needed '

	clear
}

createuserdirs(){
	if [ -f "/usr/bin/xdg-user-dirs-update" ] ; then
		xdg-user-dirs-update
		echo "User directories created"
		echo "---"
	else
		echo "Missing xdg-user-dirs, make sure it's installed"
		echo "---"
	fi
}

installyay(){
if [ -d "$PWD/yay" ] || [ -f "/usr/bin/yay" ]; then
	echo "yay already installed"
	echo "---"	
else
	pacman -Syu --needed git base-devel
	sudo -u $user git clone https://aur.archlinux.org/yay.git
	pushd yay
	sudo -u $user makepkg -si
	popd
	echo "yay installed"
	echo "---"
	
fi

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
	echo "---"
}

copyfile() {
	# $1 = /home/user/dotfiles/[srcdir] # internal
	# $2 = [destdir]                    # internal
	# $3 = [file]                       # internal
	# $4 = [mode]  VVV                  # internal
	# 1 = dontreplace 2 = backupandreplace 3 = forcereplace
	chown -R $user $(PWD)$1
	if [ -f $2$3 ]; then
		echo "$3 already exists, creating backup at $3~" 
		echo "---"
		sudo -u $user cp --backup $(PWD)/$1$3 $2/$3
	else
		sudo -u $user mkdir -p $2
		sudo -u $user cp --backup $(PWD)/$1$3 $2/$3
		echo "$h/$user copied" 
		echo "---"
	fi
}

main

: <<'ENDCOMMENT'

Install yay
Install programs
Run xdg-user-dirs
Downgrade bluez & bluezutils
Copy files
Enable services (tlp, cronie, ntp)
Hide dotfiles folder
Change shell
Warn of TODOS (Go + pipewire)

DESKTOP
dwm
st
slstatus 
^^ PATCHED

WAYLAND
swaqybg
sway
gammastep
foot
wmenu
wofi

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

