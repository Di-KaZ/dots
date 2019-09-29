#!/bin/bash

PREV=0
PREV_WK="-1"

while :; do
    CURR_WRKSPC="$(xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}')"
    WMCTRL="$(wmctrl -l)"
    WIN="$(echo "$WMCTRL" | awk -F" " '{print $2}' | grep $CURR_WRKSPC)"
    if [ -n "$WIN" ]
        then
            if [ "$PREV" != "/home/moussa/Dotfiles/.wall_tmp_blur.png" ]
                then
                    feh --bg-fill "/home/moussa/Dotfiles/.wall_tmp_blur.png"
            fi
            PREV="/home/moussa/Dotfiles/.wall_tmp_blur.png"
            sleep 0.2
        else
            if [ "$PREV" != "/home/moussa/Dotfiles/.wall_tmp.png" ]
                then
                    feh --bg-fill "/home/moussa/Dotfiles/.wall_tmp.png"
            fi
            PREV="/home/moussa/Dotfiles/.wall_tmp.png"
            sleep 0.2
    fi
done