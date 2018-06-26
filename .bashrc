[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

[ $TERM == rxvt-unicode-256color ] && [ ! -f /usr/share/terminfo/r/rxvt-unicode-256color ] && {
    # apt-get install ncurses-term
    export TERM=xterm-256color
}

# [[ $- != *i* ]] && return
# if command -v fish 2>/dev/null; then
#     exec fish
# fi
