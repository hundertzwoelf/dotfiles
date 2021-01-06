#!/bin/bash

# directory containing images
DIR="/home/patrick/Bilder/wallpapers/"

# if pidof -x "random-wall.sh"; then
    # # https://unix.stackexchange.com/a/491788/407007
    # kill -9 $(pgrep -f ${BASH_SOURCE[0]} | grep -v $$)
    # pkill -f "sleep 3600"
# fi

script_name=${BASH_SOURCE[0]}
for pid in $(pidof -x $script_name); do
    if [ $pid != $$ ]; then
        kill -9 $pid
    fi
done

while true
do
    # select a random jpg or png from the directory
    PIC=$(ls $DIR/*.{jpg,png} | shuf -n1)

    # use nitrogen to set wallpaper

    DUAL=$(cat /sys/class/drm/card0/card0-HDMI-A-2/status)


    if [ "$DUAL" == "connected" ]; then
        nitrogen --head=0 --set-zoom-fill $PIC
        nitrogen --head=1 --set-zoom-fill $PIC
    else 
        nitrogen --head=0 --set-zoom-fill $PIC
    fi
    sleep 3600
done
