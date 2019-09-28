#! /usr/bin/zsh
killall -q lemonbar

# Wait killing lemonbar instance
while pgrep -u $UID -x lemonbar >/dev/null; do sleep 1; done

# Define background foreground colo from Xresources
BG="$(xrdb -query | grep '*background'| awk '{print $NF}')"

# If compton is running activate transparency
# if [ -n "$(pgrep compton)" ]
#     then
#         BG="$(echo "$BG" | head -n1 | awk '{print $1;}')"
#         BG="$(echo ${BG:0:1}80${BG:1:6})"
# fi

# Finaly launching bar
sh ~/Dotfiles/bar/bar.sh | lemonbar -g 1920x20+0+0 -f "Cascadia Code:size=10" | sh &