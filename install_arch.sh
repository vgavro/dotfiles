#!/bin/bash
set -e
(( EUID )) && echo 'You need to be root.' && exit 1

function aur_install {
  mkdir -p /tmp/aur_install
  cd /tmp/aur_install
  git clone https://aur.archlinux.org/$1.git
  cd $1
  makepkg -si --noconfirm
  cd ..
  rm -rf $1
}
localectl set-locale LANG=en_US.UTF-8
timedatectl set-timezone Europe/Kiev
timedatectl set-local-rtc 0  # 1 for windows dual-boot
timedatectl set-ntp 1

pacman -Sy --noconfirm --needed base-devel man vim git tig wget curl fish fzf tmux ranger htop

pacman -S --noconfirm go
aur_install yay

yay -S --noconfirm terminus-font-ll2-td1-otb
yay -S --noconfirm xorg xorg-xinit xorg-xrandr xorg-xkill awesome vicious mpd ncmpcpp rxvt-unicode-patched light gnome-icon-theme qbittorrent telegram-desktop xlockmore openssh
yay -S --noconfirm ttf-google-fonts-git
yay -S --noconfirm pulseaudio pavucontrol

sudo systemctl enable sshd
