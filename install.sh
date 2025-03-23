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
fi

if [ $SHELL="zsh" ]; then
	echo "[WARN]: zsh is current shell, skipping"
else
	chsh -s /usr/bin/zsh $1
fi

if [ -f $h/.config/picom/shaders ]; then
	echo "[WARN]: grayscale shader already exists, skipping"
else
	mkdir -p $h/.config/picom/shaders/
	cp $(pwd)/grayscale.glsl $h/.config/picom/shaders/grayscale.glsl
fi

if [ -f $h/.xinitrc ]; then
	echo "[WARN]: $h/.xinitrc already exists, backing up original to $h/.xinitrcbu"
	cp $h/.xinitrc $h/.xinitrcbu
	cp $(pwd)/.xinitrc $h/.xinitrc
else
	cp $(pwd)/.xinitrc $h/.xinitrc
fi

if [ -f $h/.zshrc ]; then
	echo "[WARN]: $h/.zshrc already exists, backing up original to $h/.zshrcbu"
	cp $h/.zshrc $h/.zshrcbu
	cp $(pwd)/.zshrc $h/.zshrc
else
	cp $(pwd)/.zshrc $h/.zshrc
fi

if [ -f $h/.Xresources ]; then
	echo "[WARN]: $h/.Xresources already exists, backing up original to $h/.Xresourcesbu"
	cp $h/.Xresources $h/.Xresourcesbu
	cp $(pwd)/.Xresources $h/.Xresources
else
	cp $(pwd)/.Xresources $h/.Xresources
fi

if [ -d $h/dotfiles ]; then
	mv $h/dotfiles $h/.dotfiles
	echo "dotfiles directory is now hidden (.dotfiles)"
fi

