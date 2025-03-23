# Dotfiles
Linux dotfiles, managed with [chezmoi](https://www.chezmoi.io)

### Prerequisites
Arch with no DE

chezmoi

## Install
In your shell:
```$ chezmoi init --apply $jtirsfdr```

## Contents
- Package download scripts ```.bin/download.sh``` ```.bin/download_full.sh``` 
- Package install scripts ```.bin/install.sh``` ```.bin/install_full.sh'''
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
