#! /usr/bin/zsh

. $HOME/.cache/wal/colors.sh

declare -A SPACE
SPACE=(["1"]="One" ["2"]="Two" ["3"]="Three" ["4"]="Four" ["5"]="Five" ["6"]="Six" ["7"]="Seven" ["8"]="Height" ["9"]="Nine") ;

fnc_workspace() {
    WRK=$(xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}')

    # I don't like having a workspace named '0'
    WRK=$(($WRK + 1))
    if [ -z "$(pgrep rofi)" ]
        then
            TRUE_WRK="%{A:rofi -show drun:}%{B$color1}  WOKRSPACE  %{B-}%{B$foreground}%{F$background}  ${SPACE["$WRK"]}  %{F-}%{B-}%{A}%{F$foreground}%{F-}"
        else
            TRUE_WRK="%{B$color1}%{O161}Rofi Menu%{O161}%{B-}%{F$color1}%{F-}"
    fi

    echo $TRUE_WRK
}

fnc_launcher() {
    if [ -z "$(pgrep rofi)" ]
        then
            echo -n "%{A:rofi -show drun:}%{B$color3}  Launch  %{B-}%{A}"
        else
            echo -n "%{A:rofi -show drun:}%{B$color2}  close  %{B-}%{A}"
    fi
}

while :; do
    # Left
    BAR="%{l}"
    BAR="${BAR}$(fnc_workspace)"

    # Center

    # Right
    
    # Output result
    echo -e "$BAR"
    sleep 0.2
done