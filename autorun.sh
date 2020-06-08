#!/usr/bin/env bash

## run (only once) processes which spawn with the same name
function run {
   if (command -v $1 && ! pgrep $1); then
     $@&
   fi
}
pcmanfm --daemon &
##yandex-disk-indicator &
## run (only once) processes which spawn with different name
#if (command -v start-pulseaudio-x11 && ! pgrep pulseaudio); then
#    start-pulseaudio-x11 &
#fi
#if (command -v /usr/lib/mate-polkit/polkit-mate-authentication-agent-1 && ! pgrep polkit-mate-aut) ; then
#    /usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
#fi
#if (command -v  xfce4-power-manager && ! pgrep xfce4-power-man) ; then
#xfce4-power-manager &
#fi

#run urxvtd -q -f -o 
#run nm-applet
#run light-locker
#run xcape -e 'Super_L=Super_L|Control_L|Escape'
#run pa-applet

## The following are not included in minimal edition by default
## but autorun.sh will pick them up if you install them
##run thunar --daemon
##if (command -v system-config-printer-applet && ! pgrep applet.py ); then
##  system-config-printer-applet &
##fi
##run betterlockscreen -u $HOME/.config/awesome/themes/theme/lock) 
#xrdb -merge .Xresources &

##run msm_notifier
