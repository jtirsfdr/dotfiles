# Dotfiles

## Install
Currently only available for distros using pacman

Clone the repo:
```$ git clone https://github.com/jtirsfdr/dotfiles```

In your shell:
```$ sudo ./download.sh $USER``` or ```$ sudo ./download_full.sh $USER```

## Usage
- After install, relogin to change shells

- Start dwm with ```startx```

- Alt+P to open ```dmenu``` (package launcher)

- Further help is available at the DWM tutorial

- List of programs and usage in ```~/.dotfiles/programs```

## Contents
- Package download scripts ```.bin/download.sh``` ```.bin/download_full.sh``` 
- Package install scripts ```.bin/install.sh```
- Neovim configuration ```.config/nvim/init.vim```
- zsh configuration ```.zshrc```
- color / font mod for dwm ```.bin/dwm/```
- time / battery statusbar ```.statusbar```
- st-flexipatch  ```.bin/st-flexipatch/```
- Grayscale shader for picom ```.config/picom/shaders/grayscale.glsl```
- Startx ```.xinitrc```
- Bibata cursor ```.Xresources```
- Program reference ```.bin/programs```
- yay ```.bin/yay/``` 

### download.sh packages
- neovim
- oh my posh (pure theme)
- bibata cursor
- picom
- xorg group
- base-devel
- mpv
- ncdu
- zoxide
- yazi
- yt-dlp
- thunar
- redshift
- zsh
- acpi
- tmux
- zathura
- xsel
- xdg-user-dirs
- tlp
- 7z
- trash-cli
- nsxiv
- croc
- ssh
- quilt
- git
- fzf
- cronie
- timeshift 
- bluetuith
- downgrade

### Additional download_full.sh packages
- nitrogen
- qemu
- virt-manager
- firefox
- calibre
- moonlight
- sunshine
- anki

### Install.sh
- Installs dwm / st-flexipatch
- Sets default shell to zsh 
- Enable tlp & cronie
