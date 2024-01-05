import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import AgsBox from 'types/widgets/box';
import Gtk from 'gi://Gtk';

export default Widget.Box({
  class_names: ['workspaces'],
  spacing: 5,
  valign: Gtk.Align.CENTER,
  children: Array.from({ length: 10 }, (_, i) => i + 1).map(i => Widget.Box({
    attribute: i,
  })),
  setup: self => self.hook(Hyprland, (box) => (box.children as AgsBox[]).forEach((btn) => {
    const empty = !Hyprland.workspaces.some(ws => ws.id === btn.attribute) ? 'empty' : '';
    const active = Hyprland.active.workspace.id == btn.attribute ? 'active' : '';
    btn.class_names = ['workspace', empty, active];
  })),
});
