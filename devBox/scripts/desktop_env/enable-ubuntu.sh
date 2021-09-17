#!/bin/bash

# https://ubuntu.com/tutorials/tutorial-ubuntu-desktop-aws#3-configuring-the-vnc-server


vncserver :1 && echo "Done"

cat << EOF > ~/.vnc/xstartup
 #!/bin/sh

export XKL_XMODMAP_DISABLE=1
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS

[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey

vncconfig -iconic &
gnome-panel &
gnome-settings-daemon &
metacity &
nautilus &
gnome-terminal &
EOF

vncserver -kill :1

sleep 5

vncserver :1

## to access use tigetVnc viewer and ec2-DNS:1 with password