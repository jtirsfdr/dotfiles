systemctl enable --now tlp
systemctl enable --now cronie

xdg-user-dirs-update

cd ~/.dotfiles/dwm
make clean install

cd ~/.dotfiles/st-flexipatch
make clean install

chsh -s /usr/bin/zsh
