#!/bin/bash
set -e
(( EUID )) && echo 'You need to be root.' && exit 1

pacman -Sy --noconfirm --needed base-devel vim git tig wget curl fish fzf tmux ranger htop
which yay || {
  pacman -S --noconfirm --needed go
  ROOT=/tmp/yay_install
  rm -rf $ROOT
  sudo -u nobody mkdir $ROOT
  cd $ROOT
  sudo -u nobody git clone https://aur.archlinux.org/yay.git
  cd yay
  sudo -u nobody env GOCACHE=$ROOT makepkg --noconfirm
  pacman -U --noconfirm yay-*.pkg.tar.zst
  cd ..
  rm -rf yay
}

yay -S --noconfirm --needed xorg xorg-xinit awesome vicious mpd ncmpcpp rxvt-unicode-patched light gnome-icon-theme qbittorrent telegram-desktop xlockmore connman bluez openvpn wpa_supplicant cmst google-chrome

sudo systemctl enable connman sshd
