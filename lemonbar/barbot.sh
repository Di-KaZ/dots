#! /usr/bin/zsh

. $HOME/.cache/wal/colors.sh

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

    printf "%s%%" "$BATLVL"
}

fnc_sound() {
    if echo "$(amixer get Master)" | grep -q "off"
        then
            SOUND="%{A:pactl set-sink-mute @DEFAULT_SINK@ toggle:}mute%{A}"
        else
            # Some black magic fuckery with sed
            SOUND="%{A:pactl set-sink-mute @DEFAULT_SINK@ toggle:}$(amixer get Master | sed -n 's/^.*\[\([0-9]\+\)%.*$/\1/p'| uniq)%%{A}"
    fi
    echo $SOUND
}

fnc_date() {
    DATE="$(date '+%d/%m')"
    printf "%s" $DATE
}

fnc_time() {
    TIME="$(date '+%Hh%M')"
    printf "%s" $TIME
}

fnc_bwal() {
    echo -n "%{A:$HOME/Scripts/theme_changer.sh -r:}%{A3:$HOME/Scripts/theme_changer.sh -rl:}%{B$color2}  THEME  %{B-}%{A}%{A}"
}

while :; do
    # Left

    BAR="%{l}"
    BAR="${BAR}%{B$color4}%{O5}DATE%{O5}%{B-}%{B$foreground}%{F$background}%{O5}$(fnc_date)%{O5}%{F-}%{B-}%{O50}"
    BAR="${BAR} %{B$color5}%{O5}TIME%{O5}%{B-}%{B$foreground}%{F$background}%{O5}$(fnc_time)%{O5}%{F-}%{B-}%{O50}"
    BAR="${BAR} %{B$color6}%{O5}VOLUME%{O5}%{B-}%{B$foreground}%{F$background}%{O5}$(fnc_sound)%{O5}%{F-}%{B-}%{O50}"
    BAR="${BAR} %{B$color2}%{O5}BATTERY%{O5}%{B-}%{B$foreground}%{F$background}%{O5}$(fnc_batteries)%{O5}%{F-}%{B-}%{O50}"
    # Center

    # Right
    BAR="${BAR}%{r}"
    BAR="${BAR}$(fnc_bwal)"
    
    # Output result
    echo -e "$BAR"
    sleep 0.2
done