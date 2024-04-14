#!/usr/bin/fish

for option in $argv
    switch "$option"
        case -f --force
            set OVERWRITE 1
        case -d --desktop
            set DESKTOP 1
        case \*
            printf "error: Unknown option %s\n" $option
    end
end

set SRC (realpath (dirname (status --current-filename)))
function _map
    mkdir -vp (dirname $HOME/$argv)
    if [ $OVERWRITE ]
        rm $HOME/$argv
    end
    ln -vs $SRC/$argv $HOME/$argv
end

_map .bashrc
_map .config/fish/config.fish
_map .tmux.conf
_map .vimrc
_map .gitconfig

if [ $DESKTOP ]
    xdg-user-dirs-update

    _map .xinitrc
    _map .Xresources

    _map .config/mimeapps.list

    _map .config/awesome/rc.lua
    _map .config/awesome/vgavro-widgets
    _map .config/awesome/vgavro-theme

    _map .config/gtk-3.0/settings.ini

    _map .config/mpv

    mkdir -p .local/share/mpd
    _map .config/mpd/mpd.conf

    _map Pictures/avatar.jpg
    _map Pictures/face.jpg
    ln -s $SRC/Pictures/avatar.jpg ~/.face; or true
end

functions --erase _map
