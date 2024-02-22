import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import App from 'resource:///com/github/Aylur/ags/app.js'
import { monitorFile, exec } from 'resource:///com/github/Aylur/ags/utils.js'
import Workspaces from './widgets/workspaces.js';
import Network from './widgets/network.js';
import SysTray from './widgets/sys_tray.js';
import FocusedWindow from './widgets/focused_window.js';
import Date from './widgets/date.js';
import MediaPlayer from './widgets/media_player.js';
import Volume from './widgets/volume.js';
import Battery from './widgets/battery.js';
import Gtk from 'gi://Gtk';

const loadScss = () => {
	const scss = `${App.configDir}/style/style.scss`
	const css = `${App.configDir}/style.css`
	console.log(`[INFO] reloading css...`)
	exec(`sassc ${scss} ${css}`)
	App.resetCss()
	App.applyCss(css)
}

// auto reload css
monitorFile(
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
	anchor: ['bottom', 'left', 'right'],
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
			spacing: 20,
			children: [
				Volume,
				Network,
				Battery,
				SysTray
			]
		}),
	}),
});


export default { windows: [Bar] };
