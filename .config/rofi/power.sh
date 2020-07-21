#!/bin/bash

OPTIONS="\tLogout\n\tSuspend\n\tShutdown\n\tReboot"

option=`echo -e $OPTIONS | awk '{print $1}' | tr -d '\r\n\t'`
if [ "$@" ]
then
    case $@ in
        *Logout)
            i3-msg exit
            ;;
        *Suspend)
            systemctl suspend
            ;;
        *Shutdown)
            shutdown now
            ;;
        *Reboot)
            systemctl reboot
            ;;
    esac
else
    echo -e $OPTIONS
fi
