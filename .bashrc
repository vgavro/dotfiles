[[ $- == *i* && -z $DISPLAY && $XDG_VTNR -eq 1 && -x $(which startx) ]] && {
  mkdir -p ~/.local/share/xorg
  echo "...running startx, log file: ~/.local/share/xorg/startx.log"
  exec startx -- -keeptty > ~/.local/share/xorg/startx.log 2>&1
}

[ $TERM == rxvt-unicode-256color ] && [ ! -f /usr/share/terminfo/r/rxvt-unicode-256color ] && {
    # apt-get install ncurses-term
    [ -f /usr/share/terminfo/r/rxvt-256color ] && export TERM=rxvt-256color
    [ -f /usr/share/terminfo/r/xterm-256color ] && export TERM=xterm-256color
}
