#! /usr/bin/zsh
killall -q lemonbar

# launch it
sh $HOME/Dotfiles/lemonbar/bartop.sh | lemonbar -g 1920x20+0+0 -f "Operator Mono:size=10" | sh &
sh $HOME/Dotfiles/lemonbar/barbot.sh | lemonbar -b -g 1920x20+0+0 -f "Operator Mono:size=10" | sh &