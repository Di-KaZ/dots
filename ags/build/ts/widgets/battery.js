// /home/getmoussed/.config/ags/ts/widgets/battery.ts
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Battery from "resource:///com/github/Aylur/ags/service/battery.js";
import Gtk2 from "gi://Gtk";
var battery_default = Widget.Box({
  valign: Gtk2.Align.CENTER,
  spacing: 10,
  children: [
    Widget.Icon({
      icon: Battery.bind("icon_name")
    })
  ]
});
export {
  battery_default as default
};
