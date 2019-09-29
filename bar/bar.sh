#! /usr/bin/zsh

FG="$(xrdb -query | grep '*foreground'| awk '{print $NF}')"
COLOR0="$(xrdb -query | grep '*color0'| awk '{print $NF}')"
COLOR1="$(xrdb -query | grep '*color1'| awk '{print $NF}')"
COLOR2="$(xrdb -query | grep '*color2'| awk '{print $NF}')"
COLOR3="$(xrdb -query | grep '*color3'| awk '{print $NF}')"
COLOR4="$(xrdb -query | grep '*color4'| awk '{print $NF}')"
COLOR5="$(xrdb -query | grep '*color5'| awk '{print $NF}')"
COLOR6="$(xrdb -query | grep '*color6'| awk '{print $NF}')"

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
            echo -n "%{A:rofi -show drun:}%{F$COLOR5}  Launch%{A}%{F-}"
        else
            echo -n "%{A:rofi -show drun:}%{F$COLOR2}  close %{A}%{F-}"
    fi
}

while :; do
    # Left
    BAR="%{l}"
    BAR="${BAR}%{O10}$(fnc_launcher)"

    # Center
    BAR="${BAR}%{c}"
    BAR="${BAR}[%{F$COLOR3}$(fnc_workspace)%{F-}]"
    BAR="${BAR} %{F$COLOR4}DATE:%{F-} $(fnc_date)"
    BAR="${BAR} %{F$COLOR5}TIME:%{F-} $(fnc_time)"
    BAR="${BAR} %{F$COLOR6}VOL:%{F-} $(fnc_sound)"
    BAR="${BAR} %{F$COLOR2}BAT:%{F-} $(fnc_batteries)"

    # Right
    BAR="${BAR}%{r}"
    BAR="${BAR}%{A:shutdown 0:} %{F$COLOR5}Shutdown%{O10}%{A}%{F-}"
    
    # Output result
    echo $BAR
    sleep 0.2
done