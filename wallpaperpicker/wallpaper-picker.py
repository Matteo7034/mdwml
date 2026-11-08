#!/usr/bin/env python3
import sys
import os
import json
import subprocess
from PyQt5.QtWidgets import QApplication, QWidget, QListWidget, QListWidgetItem, QVBoxLayout, QPushButton
from PyQt5.QtGui import QIcon
from PyQt5.QtCore import QSize

WP_DIR = os.path.expanduser("~/.steam/steam/steamapps/workshop/content/431960")
ENGINE_BIN = os.path.expanduser("~/repo/linux-wallpaperengine/build/output/linux-wallpaperengine")

class WallpaperGUI(QWidget):
    def __init__(self):
        super().__init__()
        self.initUI()

    def initUI(self):
        self.setWindowTitle("Wallpaper Engine Picker")
        self.resize(800, 600)
        
        layout = QVBoxLayout()
        
        self.list_widget = QListWidget()
        self.list_widget.setIconSize(QSize(200, 112))
        self.list_widget.setViewMode(QListWidget.IconMode)
        self.list_widget.setResizeMode(QListWidget.Adjust)
        self.list_widget.setSpacing(12)
        
        self.load_wallpapers()
        layout.addWidget(self.list_widget)
        
        btn_apply = QPushButton("Imposta come Sfondo")
        btn_apply.clicked.connect(self.apply_wallpaper)
        layout.addWidget(btn_apply)
        
        self.setLayout(layout)

    def load_wallpapers(self):
        if not os.path.exists(WP_DIR):
            return
            
        for item in os.listdir(WP_DIR):
            item_path = os.path.join(WP_DIR, item)
            json_path = os.path.join(item_path, "project.json")
            
            if os.path.isdir(item_path) and os.path.exists(json_path):
                title = item
                try:
                    with open(json_path, 'r', encoding='utf-8') as f:
                        data = json.load(f)
                        title = data.get("title", item)
                except Exception:
                    pass
                
                # Cerca l'immagine di anteprima
                preview_file = None
                for ext in ["preview.jpg", "preview.png", "preview.gif"]:
                    p = os.path.join(item_path, ext)
                    if os.path.exists(p):
                        preview_file = p
                        break
                
                list_item = QListWidgetItem(title)
                # Salviamo direttamente l'ID (che è il nome della cartella) usando UserRole (ruolo standard Qt 256)
                list_item.setData(256, item) 
                
                if preview_file:
                    list_item.setIcon(QIcon(preview_file))
                
                self.list_widget.addItem(list_item)

    def apply_wallpaper(self):
        selected = self.list_widget.currentItem()
        if selected:
            # Recuperiamo l'ID usando il ruolo corretto e forziamo la stringa
            wp_id = str(selected.data(256))
            
            if not wp_id or wp_id == "None":
                print("Errore: ID non valido.")
                return

            print(f"Launching wallpaper ID: {wp_id}")
            
            # Termina l'istanza precedente
            subprocess.run(["pkill", "-f", "linux-wallpaperengine"])
            
            # Imposta le variabili d'ambiente per X11
            env = os.environ.copy()
            env["DISPLAY"] = ":0"
            env["XDG_SESSION_TYPE"] = "x11"

            wallpaper_path = os.path.join(WP_DIR, wp_id)        
            # Lancia il nuovo sfondo passando l'ID corretto
            cmd=[
                ENGINE_BIN,
    #            "--window-mode", "0",
                "--volume","50",
                "--screen-root", "eDP-1",
                wallpaper_path
            ]

            print("Comando eseguito: ",cmd)
            subprocess.Popen(cmd, env=env)
            self.close()

if __name__ == "__main__":
    app = QApplication(sys.argv)
    ex = WallpaperGUI()
    ex.show()
    sys.exit(app.exec_())
