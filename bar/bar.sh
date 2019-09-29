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

fnc_workspace() {
    WRK=$(xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}')

    # I don't like having a workspace named '0'
    WRK=$(($WRK + 1))
    echo $WRK
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
            echo -n "%{A:rofi -show drun:}%{F$color5}  Launch%{A}%{F-}"
        else
            echo -n "%{A:rofi -show drun:}%{F$color2}  close %{A}%{F-}"
    fi
}

while :; do
    # Left
    BAR="%{l}"
    BAR="${BAR}%{O10}$(fnc_launcher)"

    # Center
    BAR="${BAR}%{c}"
    BAR="${BAR}[%{F$color3}$(fnc_workspace)%{F-}]"
    BAR="${BAR} %{F$color4}DATE:%{F-} $(fnc_date)"
    BAR="${BAR} %{F$color5}TIME:%{F-} $(fnc_time)"
    BAR="${BAR} %{F$color6}VOL:%{F-} $(fnc_sound)"
    BAR="${BAR} %{F$color2}BAT:%{F-} $(fnc_batteries)"

    # Right
    BAR="${BAR}%{r}"
    BAR="${BAR}%{A:shutdown 0:} %{F$color5}Shutdown%{O10}%{A}%{F-}"
    
    # Output result
    echo $BAR
    sleep 0.2
done