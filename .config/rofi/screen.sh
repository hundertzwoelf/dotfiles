#!/bin/bash

OPTIONS="\tStandard\n\tMonitor left\n\tMonitor top"

option=`echo -e $OPTIONS | awk '{print $1}' | tr -d '\r\n\t'`
if [ "$@" ]
then
    case $@ in
        *Standard)
            $HOME/.screenlayout/normal.sh
            ;;
        *"Monitor left")
            $HOME/.screenlayout/wg.sh
            ;;
        *"Monitor top")
            $HOME/.screenlayout/fernseher.sh
            ;;
    esac
else
    echo -e $OPTIONS
fi
