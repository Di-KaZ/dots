import { Box } from "./widgets/box";
import { YuckVisitor } from "./yuck_visitor";
import { Literal } from "./widgets/literal";
import { EventBox } from "./widgets/event_box";
import { For } from "./for";
import { DefWidget } from "./defwidget";
import { DefWindow } from "./defwindow";

const workspaceWidget = new DefWidget({
  name: "workspace",
  child: new Box({
    className: "status",
    spaceEvenly: true,
    children: [
      new For({
        for: "workspaces",
        in: "{workspaces}",
        child: new EventBox({
          onclick: "hyprctl dispatch workspace ${workspace.id}",
          children: [
            new Box({
              valign: "center",
              className:
                'status__workspace ${workspace.id == workspaces_status.active_workspace_id ? "active" : ""}',
              children: [
                new Literal({
                  content:
                    '{workspace.id == workspaces_status.active_workspace_id ? "󰋘" : "󰋙"}',
                }),
              ],
            }),
          ],
        }),
      }),
    ],
  }),
});

const bar = new DefWindow({
  monitor: 0,
  name: "bar",
  namepsace: "smoussy_bar",
  stacking: "fg",
  exclusive: true,
  geometry: {
    x: "2.5%",
    y: "10px",
    anchor: "top center",
    height: "40px",
    width: "95%",
  },
  child: workspaceWidget.get(),
});

const barVisitor = new YuckVisitor();
bar.accept(barVisitor);

const worspaceVisitor = new YuckVisitor();
workspaceWidget.accept(worspaceVisitor);

console.log(worspaceVisitor.yuck);
console.log(barVisitor.yuck);
