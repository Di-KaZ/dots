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
fnc_sep() {
    echo -n "%{B$1}%{F$foreground}%{F-}"

}


fnc_sep_tag() {
    echo -n "%{F$1}%{F-}"
}

while :; do
    # Left

    BAR="%{l}%{B$color6}%{O3}%{O4}%{B-}"
    BAR="${BAR}%{B$color4} %{O15}DATE%{O5}%{B-}%{B$foreground}$(fnc_sep_tag $color4)%{F$background}%{O25}$(fnc_date)%{O25}$(fnc_sep $color5)%{F-}%{B-}"
    BAR="${BAR}%{B$color5} %{O15}TIME%{O5}%{B-}%{B$foreground}$(fnc_sep_tag $color5)%{F$background}%{O25}$(fnc_time)%{O25}$(fnc_sep $color6)%{F-}%{B-}"
    BAR="${BAR}%{B$color6} %{O15}VOLUME%{O5}%{B-}%{B$foreground}$(fnc_sep_tag $color6)%{F$background}%{O25}$(fnc_sound)%{O25}$(fnc_sep $color2)%{F-}%{B-}"
    BAR="${BAR}%{B$color2} %{O15}BATTERY%{O5}%{B-}%{B$foreground}$(fnc_sep_tag $color2)%{F$background}%{O25}$(fnc_batteries)%{O25}$(fnc_sep "#00000000")%{F-}%{B-}"
    # Center

    # # Right
    # BAR="${BAR}%{r}"
    # BAR="${BAR}$(fnc_bwal)"
    
    # Output result
    echo -e "$BAR"
    sleep 0.2
done