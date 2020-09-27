#!/bin/bash

[ -f /tmp/music.id ] || echo 0 > /tmp/music.id

players=( $(playerctl -l 2> /dev/null) )

total=( $(playerctl -l  2> /dev/null | wc -l) )

i=( $(cat /tmp/music.id) )

player=${players[0]}

for option in "$@"
do
    case $option in
        --switch)
            let new="($i + 1) % $total"
            echo $new > /tmp/music.id
            ;;
        --play)
            player=${players[$i]}
            playerctl -p $player play-pause
            ;;
        --ws)
            player=${players[$i]}
            current=$(playerctl status --player $player -f "{{playerName}}")
            i3-msg "[class="${current^}"] focus"
            ;;
    esac
done

player=${players[$i]}

[[ $i -gt $total ]] && echo 0 > /tmp/music.id

playerctl metadata --player $player --format "{{artist}} - {{title}}" 2> /dev/null
