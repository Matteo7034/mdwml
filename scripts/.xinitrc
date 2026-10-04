export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
xrandr --output  eDP-1 --mode 1600x900

~/mdwml/scripts/xsetroot.sh &

# audio
pkill -f pulseaudio 
pulseaudio > /dev/null 2>&1 & 

# compositor e sfondo 
feh --bg-fill ~/mdwml/wall/mineral.jpg &
picom &
redshift -O 3600 &

# Setta il timeout di inattività di X11 a 300 secondi (5 minuti)
xset s 300 300
xset dpms 300 300 300

# Avvia xss-lock in background accoppiato con il tuo locker preferito
xss-lock -- slock &
exec dbus-run-session -- dwm
