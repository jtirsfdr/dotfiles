# Dotfiles

## Install
Currently only available for distros using pacman

In your shell:

```
$ git clone https://github.com/jtirsfdr/dotfiles
$ cd dotfiles
$ ./install.sh
```

## Usage
- After install, relogin to update shell to zsh

- Start dwm with ```startx```

- Alt+P to open ```dmenu``` (package launcher)

- Further help is available at the [dwm tutorial](https://dwm.suckless.org/tutorial/)

- List of programs and usage in ```~/.dotfiles/programs```

## Contents
- Package install script ```~/.dotfiles/install.sh```
- Program reference ```~/.dotfiles/programs```
- time / battery statusbar ```~/.dotfiles/.statusbar```
- zsh configuration ```~/.zshrc```
- Startx ```~/.xinitrc```
- Bibata cursor ```~/.Xresources```
- Neovim configuration ```~/.config/nvim/init.vim```
- Grayscale shader for picom ```.config/picom/shaders/grayscale.glsl```
- color / font mod for dwm ```/usr/bin/dwm/```
- st-flexipatch  ```/usr/bin/st-flexipatch/```
- Wallpapers folder ```~/Pictures/Wallpapers```

## Packages downloaded
- neovim  
- picom  
- git 
- xorg 
- base-devel 
- mpv 
- ncdu 
- zoxide 
- yazi 
- yt-dlp 
- nemo 
- redshift 
- zsh 
- acpi 
- tmux 
- zathura 
- xsel 
- xdg-user-dirs 
- tlp 
- 7zip 
- trash-cli 
- nsxiv 
- croc 
- openssh 
- git 
- fzf 
- cronie 
- timeshift 
- pipewire 
- pipewire-alsa 
- pipewire-pulse 
- wireplumber 
- pulsemixer 
- xautolock 
- go 
- odin 
- fuse 
- brightnessctl 
- keepassxc 
- kleopatra 
- torbrowser-launcher 
- ttf-terminus-nerd 
- noto-fonts 
- gimp 
- github-cli 
- gnome-themes-extra 
- godot 
- imagemagick 
- man-db 
- man-pages 
- neofetch 
- nitrogen 
- xournalpp 
- blender 
- ollama 
- openssh 
- qemu-full 
- virt-manager 
- raylib 
- syncthing 
- oh my posh (pure theme)
- bibata cursor
- nitrogen
- qemu
- virt-manager
- firefox
- calibre
- moonlight
- sunshine
- anki
- yay
- bluetuith

### Install.sh
- Wrapper for commands.sh
- Installs packages / dwm / st-flexipatch / dmenu
- Adds grayscale shader for picom to config folder
- Sets default shell to zsh 
- Enable tlp, cronie, and pipewire
- Downgrade bluez to oldest version for bluetooth controller support
- Copies ```.xinitrc```, ```.zshrc```, and ```.Xresources``` to home folder
- Hides dotfiles folder ```~/.dotfiles```
