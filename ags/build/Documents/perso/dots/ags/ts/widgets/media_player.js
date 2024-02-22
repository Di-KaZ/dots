// /home/getmoussed/.config/ags/ts/widgets/media_player.ts
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Mpris from "resource:///com/github/Aylur/ags/service/mpris.js";
import Gtk2 from "gi://Gtk";
import {clamp} from "../utils/functions.js";
var Player = (player) => {
  return Widget.Box({
    class_name: "media_player",
    spacing: 10,
    children: [
      Widget.Overlay({
        child: Widget.Box({
          css: `
                min-width: 40px;
                min-height: 40px;
                border-radius: 40px;
              `
        }),
        overlays: player.cover_path ? [
          Widget.Icon({
            size: 70,
            icon: player.bind("cover_path")
          })
        ] : []
      }),
      Widget.Revealer({
        transition_duration: 500,
        transition: "slide_right",
        setup: (self) => {
          self.hook(player, (revealer) => revealer.reveal_child = player.play_back_status === "Playing");
        },
        child: Widget.Box({
          vertical: true,
          valign: Gtk2.Align.CENTER,
          children: [
            Widget.Label({
              class_names: ["media_player", "title"],
              halign: Gtk2.Align.START,
              label: player.bind("track_title").transform((track_title) => clamp(track_title, 30))
            }),
            Widget.Label({
              class_names: ["media_player", "artists"],
              halign: Gtk2.Align.START,
              label: player.bind("track_artists").transform((track_artists) => clamp(`${track_artists.join(", ")}`, 20))
            }),
            Widget.ProgressBar({
              css: `min-height: 2px; margin-top: 2px`,
              setup: (self) => {
                self.poll(1000, (pb) => {
                  const percent = player.position / player.length;
                  return pb.value = percent;
                });
              }
            })
          ]
        })
      })
    ]
  });
};
var media_player_default = Widget.Box().bind("children", Mpris, "players", (players) => {
  const firstPlayer = players.at(0);
  if (!firstPlayer || firstPlayer.play_back_status === "Stopped")
    return;
  return [Player(firstPlayer)];
});
export {
  media_player_default as default
};
