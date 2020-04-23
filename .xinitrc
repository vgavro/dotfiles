# arch-linux skeleton
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# starting pulseaudio manually because it was removed from xinitrc.d
# due https://bugs.archlinux.org/task/36077
# /usr/bin/start-pulseaudio-x11

# starting mpd, proper pid_file must be set in mpd.conf
ps -p `cat ~/.config/mpd/pid` &> /dev/null || mpd

which synclient && synclient HorizTwoFingerScroll=1

setxkbmap -option terminate:ctrl_alt_bksp
setxkbmap -layout us,ru,ua -option grp:caps_toggle -option grp:ctrls_toggle

# export QT_QPA_PLATFORMTHEME=qt5ct  qt5ct makes some shit anyway

xrdb ~/.Xresources
exec awesome
