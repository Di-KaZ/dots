import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Mpris from 'resource:///com/github/Aylur/ags/service/mpris.js';
import { MprisPlayer } from 'types/service/mpris';
import Gtk from 'gi://Gtk';
import { clamp } from '../utils/functions.js';

const Player = (player: MprisPlayer) => Widget.Box({
  class_name: 'media_player',
  spacing: 10,
  children: [
    Widget.Label({
      label: '𝅘𝅥𝅮',
      class_names: ['media_player icon'],
    }),
    Widget.Revealer({
      transition_duration: 1000,
      transition: 'slide_right',
      setup: self => {
        self.hook(player, revealer => revealer.reveal_child = player.play_back_status === 'Playing')
      },
      child: Widget.Box({
        vertical: true,
        children: [
          Widget.Label({
            class_names: ['media_player', 'title'],
            halign: Gtk.Align.START,
          }).hook(player, label => {
            const { track_title } = player;
            label.label = clamp(track_title, 30);
          }),
          Widget.Label({
            class_names: ['media_player', 'artists'],
            halign: Gtk.Align.START,
          }).hook(player, label => {
            const { track_artists } = player;
            label.label = clamp(`${track_artists.join(', ')}`, 20);
          }),
        ]
      }),
    })
  ]
})

export default Widget.Box()
  .bind('children', Mpris, 'players', players => {
    const firstPlayer = players.at(0);
    if (!firstPlayer || firstPlayer.play_back_status === 'Stopped') return undefined;
    return [Player(firstPlayer)];
  });


