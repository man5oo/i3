#!/bin/bash

BAT_PATH="/sys/class/power_supply/BAT0"
STATE_FILE="/tmp/battery_state"

LEVEL=$(cat "$BAT_PATH/capacity")
STATUS=$(cat "$BAT_PATH/status")

# Stato logico semplice
case "$STATUS" in
  Charging)    STATE="charging" ;;
  Discharging) STATE="discharging" ;;
  Full)        STATE="full" ;;
  *) exit 0 ;;
esac

# Evita doppie notifiche
[ -f "$STATE_FILE" ] && LAST=$(cat "$STATE_FILE")
[ "$STATE" = "$LAST" ] && exit 0
echo "$STATE" > "$STATE_FILE"

# Notifica finale (UNA SOLA)
case "$STATE" in
  charging)
    ICON="battery-ac-adapter-symbolic"
    TEXT="In carica ($LEVEL%)"
    ;;
  discharging)
  if [ "$LEVEL" -le "45" ]; then 
    	ICON="battery-040-symbolic"
    	TEXT="In uso ($LEVEL%)"
  else
    	ICON="battery-060-symbolic"
    	TEXT="In uso ($LEVEL%)"
  fi
    ;;
  full)
    ICON="battery-full-symbolic"
    TEXT="Carica completa"
    ;;
esac

dunstify \
  -a battery \
  -i "$ICON" \
  -u normal \
  -h int:value:"$LEVEL" \
  -h int:max:100 \
  -r 9995 \
  "Batteria $TEXT"
  
# ---- soglia batteria ----
THRESHOLD=20
LOW_FILE="/tmp/battery_low_notified"

if [ "$STATE" = "discharging" ] && [ "$LEVEL" -le "$THRESHOLD" ]; then
  if [ ! -f "$LOW_FILE" ]; then
    dunstify \
      -a battery \
      -i battery-caution-symbolic \
      -u critical \
      "Batteria bassa" \
      "$LEVEL%"
    touch "$LOW_FILE"
  fi
else
  rm -f "$LOW_FILE"
fi
