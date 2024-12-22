#!/bin/sh
#------------------------------------------------------------------------------
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/Xresources
sysmodmap=/etc/X11/xinit/Xmodmap
ServerArguments=-nolisten tcp -dpi 96

# merge in defaults and keymaps
#------------------------------------------------------------------------------
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?* ; do
   [ -x "$f" ] && . "$f"
  done
  unset f
fi

# set xautolock and dpms
#------------------------------------------------------------------------------
xautolock -detectsleep -time 10 -locker "~/.local/bin/lock.sh" &
xautolock -detectsleep -time 20 -locker "loginctl suspend" &
xset +dpms dpms 300 600 900 &

# start qtile session X
#------------------------------------------------------------------------------
exec dbus-launch --sh-syntax --exit-with-session qtile start
