// /home/getmoussed/.config/ags/ts/widgets/date.ts
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Variable from "resource:///com/github/Aylur/ags/variable.js";
var date = Variable("", {
  poll: [1000, 'date +"%H:%M \u30FB %B %d."']
});
var date_default = Widget.Label().bind("label", date);
export {
  date_default as default
};
