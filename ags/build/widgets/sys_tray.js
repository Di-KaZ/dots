// /home/getmoussed/.config/ags/ts/widgets/sys_tray.ts
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import SystemTray from "resource:///com/github/Aylur/ags/service/systemtray.js";
var SysTrayItem = (item) => Widget.Button({
  class_name: "sys_tray_btn",
  child: Widget.Icon().bind("icon", item, "icon"),
  tooltip_markup: item.bind("tooltip_markup"),
  on_primary_click: (_, event) => item.activate(event),
  on_secondary_click: (_, event) => item.openMenu(event)
});
var sys_tray_default = Widget.Box().bind("children", SystemTray, "items", (i) => i.map(SysTrayItem));
export {
  sys_tray_default as default
};
