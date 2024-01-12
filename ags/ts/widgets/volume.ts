import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';
import Gtk from 'gi://Gtk';

const VolumeSlider = (type = 'speaker') => Widget.Slider({
  css: `min-height: 5px`,
  drawValue: false,
  on_change: ({ value }) => Audio[type].volume = value,
  setup: self => self.hook(Audio, () => {
    self.value = Audio[type]?.volume || 0;
  }, `${type}-changed`),
});

export default Widget.Box({
  valign: Gtk.Align.CENTER,
  children: [
    Widget.Button({
      on_clicked: () => {
        if (!Audio.speaker) return;
        return Audio.speaker.is_muted = !Audio.speaker.is_muted;
      },
      child: Widget.Icon().hook(Audio, self => {
        if (!Audio.speaker) return;
        const vol = Audio.speaker.volume * 100;
        // @ts-ignore
        const icon = [
          [101, 'overamplified'],
          [67, 'high'],
          [34, 'medium'],
          [1, 'low'],
          [0, 'muted'],
        ].find(([threshold]) => +threshold <= vol)[1];

        self.icon = `audio-volume-${icon}-symbolic`;
        self.tooltipText = `Volume ${Math.floor(vol)}%`;
      }, 'speaker-changed'),
    }),
    VolumeSlider('speaker')
  ]
})

