#!/usr/bin/env bash

# Файл, где храним текущую яркость в процентах (по умолчанию 100)
STATE_FILE="$HOME/.cache/sunset_gamma.status"
if [ ! -f "$STATE_FILE" ]; then
    echo "100" > "$STATE_FILE"
fi

CURRENT=$(cat "$STATE_FILE")

case "$1" in
    "up")
        if [ "$CURRENT" -lt 100 ]; then
            # Прибавляем 5% в файле состояния
            NEW=$((CURRENT + 5))
            echo "$NEW" > "$STATE_FILE"

            # Отправляем в hyprsunset относительный шаг (+5%)
            hyprctl hyprsunset gamma +5%

            # Обновляем Waybar
            pkill -SIGRTMIN+11 waybar
        fi
        ;;
    "down")
        if [ "$CURRENT" -gt 10 ]; then # Минимальный порог 10%
            # Отнимаем 5% в файле состояния
            NEW=$((CURRENT - 5))
            echo "$NEW" > "$STATE_FILE"

            # Отправляем в hyprsunset относительный шаг (-5%)
            hyprctl hyprsunset gamma -5%

            # Обновляем Waybar
            pkill -SIGRTMIN+11 waybar
        fi
        ;;
    *)
        # Вывод для Waybar
        echo "${CURRENT}%"
        ;;
esac
