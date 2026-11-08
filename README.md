## Preview
![Screen](assets/screen9.png)


Requirements
------------
In order to build dwm you need the Xlib header files.
- feh
- scrot
- xorg
- Jetbrains Nerd Font "see mst"
- st (mst [Vai alla sezione Installazione](https://github.com/Matteo7034/mst) ) 
- Firefox
- dmenu
- picom
- pipewire (systemd debian)
- slock 
- xss-lock
- thunar
- python3 
- linuxwallpaper-engine (see official repo on github: [wallpaperengine](https://github.com/Almamu/linux-wallpaperengine))

Installation
------------
```bash
cd ~/
python3 -m venv venv
source ~/venv/bin/activate
pip install -r ~/mdwml/wallpaperpicker/requirements.txt --break-system-packages
cp ~/mdwml/scripts/.xinitrc ~/
cd ~/mdwml
sudo make clean install
```


