import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { TrayItem } from 'resource:///com/github/Aylur/ags/service/systemtray.js';
import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js';

const SysTrayItem = (item: TrayItem) => Widget.Button({
  class_name: 'sys_tray_btn',
  child: Widget.Icon().bind('icon', item, 'icon'),
  tooltip_markup: item.bind('tooltip_markup'),
  on_primary_click: (_, event) => item.activate(event),
  on_secondary_click: (_, event) => item.openMenu(event),
});

export default Widget.Box()
  .bind('children', SystemTray, 'items', i => i.map(SysTrayItem));


