import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import App from 'resource:///com/github/Aylur/ags/app.js'
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js'
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import Workspaces from './widgets/workspaces.js';
import SysTray from './widgets/sys_tray.js';
import FocusedWindow from './widgets/focused_window.js';
import Date from './widgets/date.js';
import MediaPlayer from './widgets/media_player.js';
import Gtk from 'gi://Gtk';

const loadScss = () => {
  const scss = `${App.configDir}/style/style.scss`
  const css = `${App.configDir}/style.css`
  console.log(`[INFO] reloading css...`)
  Utils.exec(`sassc ${scss} ${css}`)
  App.resetCss()
  App.applyCss(css)
}

// auto reload css
Utils.monitorFile(
  `${App.configDir}/style`,
  loadScss,
  'directory',
)
// first css load
loadScss();

const Bar = Widget.Window({
  monitor: 0,
  name: 'bar',
  class_name: 'bar',
  exclusivity: 'exclusive',
  anchor: ['top', 'left', 'right'],
  child: Widget.CenterBox({
    class_name: 'outer_padding',
    start_widget: Widget.Box({
      children: [
        Workspaces,
        FocusedWindow,
      ]
    }),
    center_widget: Widget.Box({
      spacing: 20,
      children: [
        Date,
        MediaPlayer,
      ]
    }),
    end_widget: Widget.Box({
      halign: Gtk.Align.END,
      children: [
        SysTray
      ]
    }),
  }),
});


export default { windows: [Bar] };
