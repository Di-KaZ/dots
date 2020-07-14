#! /usr/bin/zsh
killall -q lemonbar

# launch it
sh $HOME/Dotfiles/lemonbar/bartop.sh | lemonbar -g 1920x20+0+20 -f "Operator Mono Nerd Font:size=10" -r | sh &
sh $HOME/Dotfiles/lemonbar/barbot.sh | lemonbar -g 1920x20+0+0 -f "Operator Mono Nerd Font:size=10" | sh &