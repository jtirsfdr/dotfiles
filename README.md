# Dotfiles

## Install
Currently only available for Arch

### In your shell:

```
$ git clone https://github.com/jtirsfdr/dotfiles
$ cd dotfiles
$ ./install.sh
$ systemctl --user enable --now pipewire-pulse
```
### Relogin to switch to zsh

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

## Packages downloaded
### Review commands.sh for the most up to date list
- 7zip 
- acpi 
- anki
- base-devel 
- bibata cursor
- blender 
- bluetuith
- brightnessctl 
- calibre
- croc 
- cronie 
- firefox
- fuse 
- fzf 
- gimp 
- git 
- git 
- github-cli 
- gnome-themes-extra 
- go 
- godot 
- gotop
- imagemagick 
- keepassxc 
- kleopatra 
- maimmega
- man-db 
- man-pages 
- megatools
- moonlight
- mpv 
- ncdu 
- nemo 
- neofetch 
- neovim  
- nitrogen
- nitrogen 
- noto-fonts 
- nsxiv 
- odin 
- oh my posh (probua minimal theme)
- ollama 
- openssh 
- openssh 
- picom  
- pipewire 
- pipewire-alsa 
- pipewire-pulse 
- pulsemixer 
- qemu
- qemu-full 
- raylib 
- redshift 
- sunshine
- syncthing 
- timeshift 
- tlp 
- tmux 
- torbrowser-launcher 
- trash-cli 
- ttf-terminus-nerd 
- virt-manager
- virt-manager 
- wireplumber 
- xautolock 
- xdg-user-dirs 
- xorg 
- xournalpp
- xsel 
- yay
- yazi 
- yt-dlp 
- zathura 
- zbar
- zoxide 
- zsh 

### Install.sh
- Wrapper for commands.sh
- Installs packages / dwm / st-flexipatch / dmenu
- Adds grayscale shader for picom to config folder
- Sets default shell to zsh
- Enables autologin on tty1
- Enable tlp and cronie
- Downgrade bluez to oldest version for bluetooth controller support
- Configures neovim w/ vim-plug
- Configures yazi
- Copies ```.xinitrc```, ```.zshrc```, ```.zprofile``` and ```.Xresources``` to home folder
- Hides dotfiles folder ```~/.dotfiles```

### TODO
- Allow destructive installs (no backups)
- Disable log file flag
- Program to convert aliases to binaries for dmenu
 
