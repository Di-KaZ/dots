// /home/getmoussed/.config/ags/ts/widgets/volume.ts
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Audio from "resource:///com/github/Aylur/ags/service/audio.js";
import Gtk2 from "gi://Gtk";
var VolumeSlider = (type = "speaker") => Widget.Slider({
  css: `min-height: 5px`,
  drawValue: false,
  on_change: ({ value }) => Audio[type].volume = value,
  setup: (self) => self.hook(Audio, () => {
    self.value = Audio[type]?.volume || 0;
  }, `${type}-changed`)
});
var volume_default = Widget.Box({
  valign: Gtk2.Align.CENTER,
  children: [
    Widget.Button({
      on_clicked: () => {
        if (!Audio.speaker)
          return;
        return Audio.speaker.is_muted = !Audio.speaker.is_muted;
      },
      child: Widget.Icon().hook(Audio, (self) => {
        if (!Audio.speaker)
          return;
        const vol = Audio.speaker.volume * 100;
        const icon = [
          [101, "overamplified"],
          [67, "high"],
          [34, "medium"],
          [1, "low"],
          [0, "muted"]
        ].find(([threshold]) => +threshold <= vol)[1];
        self.icon = `audio-volume-${icon}-symbolic`;
        self.tooltipText = `Volume ${Math.floor(vol)}%`;
      }, "speaker-changed")
    }),
    VolumeSlider("speaker")
  ]
});
export {
  volume_default as default
};
