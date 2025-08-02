# Dotfiles
![preview](./preview.jpg?raw=true)

## Install
Dependencies:

base-devel
git
sudo
gpg

### Autoinstall (recommended):
```
sudo pacman -Syu --needed base-devel git sudo gpg
git clone https://github.com/jtirsfdr/dotfiles --recurse-submodules
cd dotfiles
./install.sh --auto
systemctl --user enable --now pipewire-pulse
go env -w GOPATH=$HOME/.go
reboot
```

[NOTE]

greetd has a tendency to break, make sure you're familiar with
how to switch VTs (Ctrl+Alt+F2).

### Post configuration

## Relogin to switch to zsh

In Neovim:

```:PlugInstall```

### For Mega.nz screenshot uploads:

In ```~/.megarc```

```
[Login]
Username = [EMAIL]
Password = [PASSWORD]
```
In your shell: ```$ maimmega```

## Tips
- Alt+P to open ```dmenu``` (package launcher)
- A list of programs and usage is available in ```~/.dotfiles/programs```
- Disable grayscale with ```$ pkill picom```
- [dwm tutorial](https://dwm.suckless.org/tutorial/)
- Review aliases in .zshrc for helpful commands

## Contents
- Package install script ```~/.dotfiles/install.sh``` ```~/.dotfiles/commands.sh```
- Program reference ```~/.dotfiles/programs```
- Time / battery statusbar ```~/.dotfiles/home/.statusbar```
- zsh configuration ```~/.zshrc```
- dwm / X11 configuration ```~/.xinitrc```
- Autostart on tty1 login ```~/.zprofile```
- Bibata cursor ```~/.Xresources```
- Neovim configuration ```~/.config/nvim/init.vim```
- Grayscale shader for picom ```.config/picom/shaders/grayscale.glsl```
- Color / font mod for dwm ```/usr/bin/dwm/```
- Patched st ```/usr/bin/st-flexipatch/```
- Wallpapers folder ```~/Pictures/Wallpapers```

## Full package list
- 7zip
- acpi
- adwaita-qt5-git
- adwaita-qt6-git
- base
- base-devel
- bat
- bibata-cursor-theme-bin
- blender
- bluetuith
- bluez
- bluez-utils 
- brightnessctl 
- btop
- cowsay 
- croc 
- cronie 
- dmenu
- dnsmasq 
- downgrade
- dragon-drop
- duf 
- dust 
- eza 
- fastfetch 
- fbcat
- fd 
- feh
- foot
- fuse 
- fzf
- gammastep
- gimp
- git
- github-cli
- gnome-themes-extra
- go
- godot
- greetd
- greetd-tuigreet
- htop
- imagemagick
- informant
- ipcalc
- keepassxc
- kleopatra
- kmon
- lazygit
- links
- localsend
- lolcat
- lxappearance
- man-db
- man-pages
- mc
- micro
- moonlight-qt
- mpv
- ncdu
- neovim
- net-tools
- networkmanager
- noto-fonts
- noto-fonts-cjk
- nsxiv
- obs-studio
- odin
- ollama
- openssh
- picom
- pipewire
- pipewire-alsa
- pipewire-pulse
- pulsemixer
- python
- python-pywal16
- qemu-full
- raylib
- redshift
- rofi
- rustup
- sl
- sof-firmware
- strace 
- sudo
- swaqybg
- sway
- swtpm
- syncthing
- tealdeer
- terminus-font
- tgpt
- timeshift 
- tlp 
- tmux
- torbrowser-launcher
- traceroute
- trash-cli
- tree
- ttf-liberation-mono-nerd
- ttf-noto-nerd
- ttf-terminus-nerd
- ufw 
- unp
- uv
- vi
- vim
- virt-manager
- whois
- wireless_tools
- wireplumber 
- wmenu
- wofi
- xclip
- xdg-user-dirs 
- xdotool
- xinit-xsession
- xlayoutdisplay
- xorg
- xournalpp
- xsel
- yazi 
- yt-dlp 
- zathura 
- zbar 
- zellij 
- zip 
- zoxide 
- zsh 
- zsh-vi-mode

### Script overview: 

## install.sh
- Wrapper for commands.sh, passes sudo + current user + auto flag to script

## commands.sh
- Simple UI for post-configuration
- Installs patched dwm, st, and slstatus
- Creates user directories
- Hides /dotfiles to /.dotfiles
- Sets default shell to zsh

## /pkg/
- Contains custom package groups for commands.sh

## /config/
- Contains configuration files for programs + custom shell programs
- Picom grayscale filter + shadowless config
- Enable tlp, greetd, and cronie (power saving, login manager, and timed task scheduler)
- Downgrade bluez to oldest version for bluetooth controller support
- Neovim config
- Configures yazi
- Houses rc / profile files 

### TODO
- Add log + auto flag
- Finish menu UI
- Make dotdeploy

