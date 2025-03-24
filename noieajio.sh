h="/home/$1"
echo "Installing to: $h"

systemctl enable --now tlp
systemctl enable --now cronie

xdg-user-dirs-update

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

if [ $SHELL="zsh" ]; then
	echo "[WARN]: zsh is current shell, skipping"
else
	chsh -s /usr/bin/zsh $1
	echo "[DONE]: Current shell is zsh"
fi

if [ -f $h/.config/picom/shaders ]; then
	echo "[WARN]: Grayscale shader already exists, skipping"
else
	mkdir -p $h/.config/picom/shaders/
	cp $(pwd)/grayscale.glsl $h/.config/picom/shaders/grayscale.glsl
	echo "[DONE]: Grayscale picom shader installed"
fi

if [ -f $h/.xinitrc ]; then
	echo "[WARN]: $h/.xinitrc already exists, backing up original to $h/.xinitrcbu"
	cp $h/.xinitrc $h/.xinitrcbu
	cp $(pwd)/.xinitrc $h/.xinitrc
else
	cp $(pwd)/.xinitrc $h/.xinitrc
	echo "[DONE]: $h/.xinitrc copied" 
fi

if [ -f $h/.zshrc ]; then
	echo "[WARN]: $h/.zshrc already exists, backing up original to $h/.zshrcbu"
	cp $h/.zshrc $h/.zshrcbu
	cp $(pwd)/.zshrc $h/.zshrc
else
	cp $(pwd)/.zshrc $h/.zshrc
	echo "[DONE]: $h/.zshrc copied"
fi

if [ -f $h/.Xresources ]; then
	echo "[WARN]: $h/.Xresources already exists, backing up original to $h/.Xresourcesbu"
	cp $h/.Xresources $h/.Xresourcesbu
	cp $(pwd)/.Xresources $h/.Xresources
else
	cp $(pwd)/.Xresources $h/.Xresources
	echo "[DONE]: $h/.Xresources copied"
fi

if [ -d $h/dotfiles ]; then
	mv $h/dotfiles $h/.dotfiles
	echo "[DONE]: Dotfiles directory is now hidden ($h/.dotfiles)"
fi

