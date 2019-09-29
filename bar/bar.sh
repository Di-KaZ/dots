#! /usr/bin/zsh

. ~/.cache/wal/colors.sh

fnc_batteries() {
    # saving batteries percentages && status
    MAXC="39020000" # I calculated it
    BATC1="$(cat /sys/class/power_supply/BAT1/energy_now)"
    BATC0="$(cat /sys/class/power_supply/BAT0/energy_now)"
    BATS1="$(cat /sys/class/power_supply/BAT1/status)"
    BATS0="$(cat /sys/class/power_supply/BAT0/status)"

    # Making average of both battery
    BATLVL=$(($BATC1 + $BATC0))
    BATLVL=$(echo "100 * $BATLVL / $MAXC" | bc)
    # If one of the battery is charging display it
    if [ $BATS1 = "Charging" ] || [ $BATS0 = "Charging" ]
        then
            CHARG='+'
        else
            CHARG='-'
    fi
    printf "%s%s%%" "$CHARG" "$BATLVL"
}

fnc_sound() {
    if echo "$(amixer get Master)" | grep -q "off"
        then
            SOUND="mute"
        else
            # Some black magic fuckery with sed
            SOUND="$(amixer get Master | sed -n 's/^.*\[\([0-9]\+\)%.*$/\1/p'| uniq)%"
    fi
    echo $SOUND
}

declare -A SPACE
SPACE=(["1"]="One" ["2"]="Two" ["3"]="Three" ["4"]="Four" ["5"]="Five" ["6"]="Six" ["7"]="Seven" ["8"]="Height" ["9"]="Nine") ;

fnc_workspace() {
    WRK=$(xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}')

    # I don't like having a workspace named '0'
    WRK=$(($WRK + 1))
    TRUE_WRK="%{B$color1}  ${SPACE["$WRK"]}  %{B-}"

    echo $TRUE_WRK
}

fnc_date() {
    DATE="$(date '+%d/%m')"
    printf "%s" $DATE
}

fnc_time() {
    TIME="$(date '+%Hh%M')"
    printf "%s" $TIME
}

fnc_launcher() {
    if [ -z "$(pgrep rofi)" ]
        then
            echo -n "%{A:rofi -show drun:}%{B$color3}  Launch  %{B-}%{A}"
        else
            echo -n "%{A:rofi -show drun:}%{B$color2}  close  %{B-}%{A}"
    fi
}

fnc_bwal() {
    echo -n "%{A:/home/moussa/Dotfiles/berry/bwal:}%{B$color2}  THEME  %{B-}%{A}"
}

while :; do
    # Left
    BAR="%{l}"
    BAR="${BAR}$(fnc_workspace)"
    BAR="${BAR}$(fnc_launcher)"

    # Center
    BAR="${BAR}%{c}%{U$color4}%{+u}.."
    BAR="${BAR}%{F$color4}DATE:%{F-} $(fnc_date)"
    BAR="${BAR} %{F$color5}TIME:%{F-} $(fnc_time)"
    BAR="${BAR} %{F$color6}VOL:%{F-} $(fnc_sound)"
    BAR="${BAR} %{F$color2}BAT:%{F-} $(fnc_batteries)"
    BAR="${BAR}..%{-u}%{U-}"
    # Right
    BAR="${BAR}%{r}"
    BAR="${BAR}%{A:shutdown 0:}%{B$color4}  Shutdown  %{B-}%{A}"
    BAR="${BAR}$(fnc_bwal)"
    
    # Output result
    echo -e "$BAR"
    sleep 0.2
done