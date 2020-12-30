#!/bin/bash

OPTIONS="\tSuspend\n\tLogout\n\tShutdown\n\tReboot\n\tRestart LightDM"


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
        *"Restart LightDM")
            pkill rofi
            systemctl restart lightdm
            ;;
    esac
else
    echo -e $OPTIONS
fi
