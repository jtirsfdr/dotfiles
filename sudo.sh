pacman -Syu

echo "cloning yay"
mkdir -p /home/$1/.dotfiles && cd /home/$1/.dotfiles
sudo -u $1 git clone https://aur.archlinux.org/yay.git
cd yay
sudo -u $1 makepkg -si

