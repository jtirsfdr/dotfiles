# Dotfiles

## Install
Currently only available for distros using pacman

Clone the repo:
```$ git clone https://github.com/jtirsfdr/dotfiles```

In your shell:
```$ ./install.sh

## Usage
- After install, relogin to change shells

- Start dwm with ```startx```

- Alt+P to open ```dmenu``` (package launcher)

- Further help is available at the DWM tutorial

- List of programs and usage in ```~/.dotfiles/programs```

## Contents
- Package install script ```.bin/install.sh```
- Neovim configuration ```.config/nvim/init.vim```
- zsh configuration ```.zshrc```
- color / font mod for dwm ```.bin/dwm/```
- time / battery statusbar ```.statusbar```
- st-flexipatch  ```.bin/st-flexipatch/```
- Grayscale shader for picom ```.config/picom/shaders/grayscale.glsl```
- Startx ```.xinitrc```
- Bibata cursor ```.Xresources```
- Program reference ```.bin/programs```

### download.sh packages
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
 nitrogen
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
- Enable tlp & cronie, and pipewire
- Downgrade bluez to oldest version for bluetooth controller support
- Copies ```.xinitrc```, ```.zshrc```, and ```.Xresources``` to home folder
- Hides dotfiles folder ```~/.dotfiles```
