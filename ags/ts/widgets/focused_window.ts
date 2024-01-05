import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { clamp } from '../utils/functions.js';


export default Widget.Label({
  label: Hyprland.active.client.bind('title').transform((title) => clamp(title, 30)),
  visible: Hyprland.active.client.bind('address')
    .transform(addr => !!addr),
});
