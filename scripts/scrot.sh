#!/bin/bash

# Cartella di destinazione
TARGET_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$TARGET_DIR"

# Nome del file con data e ora
FILE_NAME="screenshot_$(date +'%Y%m%d_%H%M%S').png"
FULL_PATH="$TARGET_DIR/$FILE_NAME"

# Notifica inizio selezione
#notify-send "Screenshot" "Seleziona un'area con il mouse..."

# Cattura la regione
scrot -s "$FULL_PATH"

# Se l'utente non ha annullato, copia negli appunti e notifica
if [ -f "$FULL_PATH" ]; then
    xclip -selection clipboard -t image/png -i "$FULL_PATH"
    #notify-send "Screenshot" "Salvato e copiato negli appunti!"
fi

