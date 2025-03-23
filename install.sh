systemctl enable --now tlp
systemctl enable --now cronie

xdg-user-dirs-update

cd ~/.dotfiles/dwm
make clean install

cd ~/.dotfiles/st-flexipatch
make clean install

chsh -s /usr/bin/zsh

mkdir -p ~/.config/picom/shaders/
mv ./grayscale.glsl ~/.config/picom/shaders/grayscale.glsl

cp ./.xinitrc ~/.xinitrc
cp ./zshrc ~/.zshrc
cp ./.Xresources ~/.Xresources

mv ~/dotfiles ~/.dotfiles

