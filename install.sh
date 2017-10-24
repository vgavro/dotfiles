#!/usr/bin/fish
# TODO: add override option with renaming

mkdir -vp ~/.config/fish
ln -vs $PWD/.config/fish/config.fish ~/.config/fish/config.fish

ln -vs $PWD/.tmux.conf ~/.tmux.conf
ln -vs $PWD/.vimrc ~/.vimrc
ln -vs $PWD/.gitconfig ~/.gitconfig

# DESKTOP
ln -vs $PWD/.xinitrc ~/.xinitrc
ln -vs $PWD/.Xresources ~/.Xresources

mkdir -vp ~/.config/awesome
ln -vs $PWD/.config/awesome/rc.lua ~/.config/awesome/rc.lua
ln -vs $PWD/.config/awesome/vgavro-widgets ~/.config/awesome/
ln -vs $PWD/.config/awesome/vgavro-theme ~/.config/awesome/

mkdir -vp ~/.config/gtk-3.0
ln -vs $PWD/.config/gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini

ln -vs $PWD/.gtkrc-2.0 ~/.gtkrc-2.0

mkdir -vp ~/.config/mpd
ln -vs $PWD/.config/mpd/mpd.conf ~/.config/mpd/mpd.conf

mkdir -vp ~/Pictures
ln -vs $PWD/Pictures/avatar.jpg ~/Pictures/avatar.jpg
ln -vs $PWD/Pictures/face.jpg ~/Pictures/face.jpg
