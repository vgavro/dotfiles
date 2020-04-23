[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

[ $TERM == rxvt-unicode-256color ] && [ ! -f /usr/share/terminfo/r/rxvt-unicode-256color ] && {
    # apt-get install ncurses-term
    [ -f /usr/share/terminfo/r/rxvt-256color ] && export TERM=rxvt-256color
    [ -f /usr/share/terminfo/r/xterm-256color ] && export TERM=xterm-256color
}
\n# Add the directory of Tizen .NET Command Line Tools to user path.\nexport PATH=/home/vgavro/tizen-studio/tools/ide/bin:$PATH
