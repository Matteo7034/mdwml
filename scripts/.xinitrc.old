export __GL_MaxFramesAllowed=1
export __GL_YIELD="USLEEP"
export __GL_THREADED_OPTIMIZATIONS=1

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export XIM=fcitx


export XDG_SESSION_TYPE=x11
export DESKTOP_SESSION=dwm


xrandr --output eDP-1 --mode 1600x900
#xrandr --output eDP-1 --mode 1920x1080 --output HDMI-1 --mode 1920x1080 --same-as eDP-1

#compositor
pkill -f picom
picom --daemon &

pkill -f pulseaudio
pulseaudio > /dev/null 2>&1 &

#night light
redshift -O 3600 &


if [ -x /usr/bin/dbus-update-activation-environment ]; then
    dbus-update-activation-environment --all GTK_IM_MODULE QT_IM_MODULE XMODIFIERS
fi

(sleep 2 && birghtnessctl set 10% ) &
# sfondo
feh --bg-fill ~/mdwm/wall/cherrycloud.jpg &
~/mdwm/scripts/xsetroot.sh &
# Esegui la sessione D-Bus con dwm
exec dbus-run-session dwm

#export DISPLAY=foo.bar:1 exec dwm
