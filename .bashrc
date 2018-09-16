[[ $- != *i* ]] && return
# Because of "skeleton" and all this scaffolding shit pattern local .bashrc is not useful anyway

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

[ $TERM == rxvt-unicode-256color ] && [ ! -f /usr/share/terminfo/r/rxvt-unicode-256color ] && {
    # apt-get install ncurses-term
    if [ -f /usr/share/terminfo/r/rxvt-256color ]
        export TERM=rxvt-256color
    else
        export TERM=xterm-256color
    fi
}

if command -v fish 2>/dev/null; then
    exec fish
fi
