#! /usr/bin/zsh
killall -q lemonbar

# launch it
sh $HOME/.config/lemonbar/bartop.sh | lemonbar -g 1920x20+0+0 -f "Cascadia Code:size=10" | sh &
sh $HOME/.config/lemonbar/barbot.sh | lemonbar -b -g 1920x20+0+0 -f "Cascadia Code:size=10" | sh &