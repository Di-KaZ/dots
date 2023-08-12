import { DefWidget } from "./defwidget";
import { DefWindow } from "./defwindow";
import { For } from "./for";
import { Box } from "./widgets/box";
import { Custom } from "./widgets/custom_widget";
import { EventBox } from "./widgets/event_box";
import { Literal } from "./widgets/literal";
import { Revealer } from "./widgets/revealer";

export abstract class NodeVisitor {
  abstract visitDefWindow(defwindow: DefWindow): void;
  abstract visitFor(fo: For): void;
  abstract visitDefWidget(defwidget: DefWidget): void;
  abstract visitBox(box: Box): void;
  abstract visitLiteral(literal: Literal): void;
  abstract visitEventBox(eventbox: EventBox): void;
  abstract visitRevealer(revealer: Revealer): void;
  abstract visitCustom(custom: Custom): void;
}
