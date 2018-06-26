#!/usr/bin/fish
#
set SRC (dirname (status --current-filename))
function _map
    # TODO: add override option with renaming
    mkdir -vp (dirname $HOME/$argv)
    ln -vs $SRC/$argv $HOME/$argv
end

_map .config/fish/config.fish

_map .tmux.conf
_map .vimrc
_map .gitconfig

# DESKTOP
# _map .xinitrc
# _map .Xresources
#
# _map .config/awesome/rc.lua
# _map .config/awesome/vgavro-widgets
# _map .config/awesome/vgavro-theme
#
# _map .config/gtk-3.0/settings.ini
#
# _map .gtkrc-2.0
#
# _map .config/mpd/mpd.conf
#
# _map Pictures/avatar.jpg
# _map Pictures/face.jpg

functions --erase _map
