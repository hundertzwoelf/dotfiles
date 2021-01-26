#!/bin/bash

# create player index file and set it to nil
[ -f /tmp/music.id ] || echo 0 > /tmp/music.id

# gather player list, total number, current index and current player
players=( $(playerctl -l 2> /dev/null) )
total=( $(playerctl -l  2> /dev/null | wc -l) )
i=( $(cat /tmp/music.id) )
player=${players[$i]}

# exit if total is nil
[ $total -eq 0 ] && echo #&& exit


# skip stopped players (playerctl retains stopped chromium instances)
# same code as for switch, maybe reuse code ~TODO?
if [ $(playerctl status --player $player 2> /dev/null) == "Stopped" ] ; then
    let new="($i+1) % total"
    player=${players[$new]}
    echo $new > /tmp/music.id
    # exit
fi

# set the index back to 0
let last=$(( $total - 1 ))
[[ $i -gt $last ]] && echo 0 > /tmp/music.id

# handle command line options for switching, play-pause and focussing the ws
for option in "$@"
do
    case $option in
        --switch)
            let new="($i + 1) % $total"
            player=${players[$new]}
            echo $new > /tmp/music.id
            exit
            ;;
        --play)
            playerctl -p $player play-pause
            ;;
        --ws)
            current=$(playerctl status --player $player -f "{{playerName}}")
            i3-msg "[class="${current^}"] focus"
            ;;
    esac
done

# pretty printing of the output
# playerctl metadata --player $player --format "〔{{ playerName }}〕{{artist}} | {{ title }}" 2> /dev/null
playerctl metadata --player $player --format "{{ playerName }}┃{{artist}}┃{{ title }}" 2> /dev/null
