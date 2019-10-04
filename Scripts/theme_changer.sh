#!/bin/bash



l=0
r=0
# get args
OPTIND=1
while getopts ":rlw:" option; do
    case "${option}" in
        r)
            r=1;;
        l)
            l=1;;
        w)
            w=${OPTARG};; # if path to wallpaper is given use it
        *)
            printf "USAGE :\n\t-r\t[set random wallpaper]\n\t-l\t[light theme]\n\t-w\t[wallpaper path]\n"
            exit 0
            ;;
    esac
done

shift $((OPTIND-1))


if [ -v "$r" ] && [ -v "$w" ]
    then
        echo -e "-r and -w mutual exclusive"
fi

# if random is set use random background
if [ "$r" -eq 1 ]
    then
        WALL="$(ls $HOME/wallpapers | shuf -n 1)"
        w="$HOME/wallpapers/$WALL"
fi

# if light is set tell pywal to generate light sheme
if [ "$l" -eq 1 ]
    then
        wal -l -i "$w" -n -q
    else
        wal -i "$w" -n -q
fi

# kill previous instance

to_kill="$(pgrep -f pywalblur)"

if [ ! -z "$to_kill" ]
    then
        kill $to_kill
    else
        echo "No pywalblur bg instance detected"
fi

sh $HOME/.cache/wal/berrycolor
sh $HOME/.config/lemonbar/launchbar.sh
python3 $HOME/Scripts/pywalblur -w "$w" &
notify-send -i "$w" "Updated theme !"