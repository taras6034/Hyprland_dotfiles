#!/bin/bash

if ! pgrep -x "waybar" > /dev/null; then
    waybar & disown
fi
