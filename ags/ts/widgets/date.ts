import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';

import Variable from 'resource:///com/github/Aylur/ags/variable.js';

const date = Variable('', {
  poll: [1000, 'date +"%H:%M ・ %B %d."',],
});

export default Widget.Label().bind('label', date);
