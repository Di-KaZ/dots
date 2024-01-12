import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';
import Gtk from 'gi://Gtk';

export default Widget.Box({
  valign: Gtk.Align.CENTER,
  spacing: 10,
  children: [
    Widget.Icon({
      icon: Battery.bind('icon_name')
    }),
  ],
});
