#!/usr/bin/fish
# TODO: add override option with renaming

mkdir -p ~/.config/fish 
ln -s $PWD/.config/fish/config.fish ~/.config/fish/config.fish
ln -s $PWD/.tmux.conf ~/.tmux.conf
ln -s $PWD/.vimrc ~/.vimrc
ln -s $PWD/.gitconfig ~/.gitconfig

# DESKTOP
mkdir -p ~/.config/awesome 
ln -s $PWD/.config/awesome/rc.lua ~/.config/awesome/rc.lua
ln -s $PWD/.config/awesome/vgavro-widgets ~/.config/awesome/vgavro-widgets
ln -s $PWD/.config/awesome/vgavro-theme ~/.config/awesome/vgavro-theme

mkdir -p ~/.config/mpd 
ln -s $PWD/.config/mpd/mpd.conf ~/.config/mpd/mpd.conf
ln -s $PWD/.xinitrc ~/.xinitrc

mkdir -p ~/Pictures
ln -s $PWD/Pictures/avatar.jpg ~/Pictures/avatar.jpg
ln -s $PWD/Pictures/face.jpg ~/Pictures/face.jpg
