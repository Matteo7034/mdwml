#!/bin/bash

while true; do
    # Percorso della batteria (cambia BAT0 in BAT1 se non legge i dati)
    BAT_PATH="/sys/class/power_supply/BAT0"

    if [ -d "$BAT_PATH" ]; then
        # Percentuale della batteria
        BAT_CAP=$(cat "$BAT_PATH/capacity")
        
        # Stato (Charging, Discharging, Full, ecc.)
        BAT_STATUS=$(cat "$BAT_PATH/status")

        # Calcolo del consumo in Watt
        # La maggior parte dei kernel espone la potenza istantanea in microwatt (power_now)
        if [ -f "$BAT_PATH/power_now" ]; then
            POWER_MW=$(cat "$BAT_PATH/power_now")
            WATTS=$(awk "BEGIN {printf \"%.1fW\", $POWER_MW / 1000000}")
        # Alcuni sistemi usano corrente (current_now in microampere) e tensione (voltage_now in microvolt)
        elif [ -f "$BAT_PATH/current_now" ] && [ -f "$BAT_PATH/voltage_now" ]; then
            CURRENT=$(cat "$BAT_PATH/current_now")
            VOLTAGE=$(cat "$BAT_PATH/voltage_now")
            WATTS=$(awk "BEGIN {printf \"%.1fW\", ($CURRENT * $VOLTAGE) / 1000000000000}")
        else
            WATTS="N/A"
        fi

        # Formattazione dell'icona/testo dello stato
        if [ "$BAT_STATUS" = "Charging" ]; then
            BAT_INFO="BAT: ${BAT_CAP}% [+$WATTS]"
        elif [ "$BAT_STATUS" = "Discharging" ]; then
            BAT_INFO="BAT: ${BAT_CAP}% [-$WATTS]"
        else
            BAT_INFO="BAT: ${BAT_CAP}% [$BAT_STATUS]"
        fi
    else
        BAT_INFO="BAT: N/A"
    fi

    # Sistema, Memoria e Data
    LINUX="Linux: $(uname -r)"
    MEM="$(free -h | awk '/^Mem:/ {print $3}')"
    DATE="$(date '+%H:%M | %a | %d/%m/%y')"

    # Output su xsetroot
    xsetroot -name " $LINUX | MEM: $MEM | $BAT_INFO | $DATE "

    sleep 10
done
