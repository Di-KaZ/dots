import { Box } from "./widgets/box";
import { Widget } from "./widgets/widget";
import { NodeVisitor } from "./node_visitor";
import { Literal } from "./widgets/literal";
import { EventBox } from "./widgets/event_box";
import { Revealer } from "./widgets/revealer";
import { For } from "./for";
import { DefWidget } from "./defwidget";
import { DefWindow } from "./defwindow";
import { Custom } from "./widgets/custom_widget";

function _padder(times: number): string {
  return "  ".repeat(times);
}

function _property(key: string, value?: string | number | boolean): string {
  if (value !== undefined) {
    if (typeof value !== "string") {
      return `:${key} ${value}`;
    }
    return `:${key} '${value}'`;
  }
  return "";
}

function _widgetProperty(widget: Widget, indentLevel: number) {
  const indent = _padder(indentLevel);
  return `
${indent}${_property("class", widget.className)}
${indent}${_property("valign", widget.valign)}
${indent}${_property("halign", widget.halign)}
${indent}${_property("vexpand", widget.vexpand)}
${indent}${_property("hexpand", widget.hexpand)}
${indent}${_property("width", widget.width)}
${indent}${_property("height", widget.height)}
${indent}${_property("active", widget.active)}
${indent}${_property("tooltip", widget.tooltip)}
${indent}${_property("visible", widget.visible)}
${indent}${_property("style", widget.style)}
${indent}${_property("css", widget.css)}
  `;
}

function _widget(
  widget: Widget,
  additionalFields: { key: string; value?: number | string | boolean }[],
  indentLevel: number,
  children: Widget[] = []
) {
  const indent = _padder(indentLevel);
  return `
${indent}(${widget.name}
${widget.comment ? `; ${widget.comment}` : ""}
${_widgetProperty(widget, indentLevel + 1)}
${additionalFields
  .map(
    ({ key, value }) => `${_padder(indentLevel + 1)}${_property(key, value)}`
  )
  .join("\n")}
${children
  .map((child) => {
    const childVisitor = new YuckVisitor();
    childVisitor.indentLevel = indentLevel + 1;
    child.accept(childVisitor);
    return childVisitor.yuck;
  })
  .join("")}
${indent})
`;
}

export class YuckVisitor implements NodeVisitor {
  yuck: string = "";
  indentLevel = 0;

  visitBox(box: Box): void {
    this.yuck = _widget(
      box,
      [
        { key: "spacing", value: box.spacing },
        { key: "orientation", value: box.orientation },
        { key: "space-evenly", value: box.spaceEvenly },
      ],
      this.indentLevel,
      box.children
    );
  }

  visitLiteral(literal: Literal): void {
    this.yuck = _widget(
      literal,
      [{ key: "content", value: literal.content }],
      this.indentLevel
    );
  }

  visitEventBox(eventbox: EventBox): void {
    this.yuck = _widget(
      eventbox,
      [
        { key: "timeout", value: eventbox.timeout },
        { key: "onscroll", value: eventbox.onscroll },
        { key: "onhover", value: eventbox.onhover },
        { key: "onhoverlost", value: eventbox.onhoverlost },
        { key: "cursor", value: eventbox.cursor },
        { key: "ondropped", value: eventbox.ondropped },
        { key: "dragvalue", value: eventbox.dragvalue },
        { key: "dragtype", value: eventbox.dragtype },
        { key: "onclick", value: eventbox.onclick },
        { key: "onmiddleclick", value: eventbox.onmiddleclick },
        { key: "onrightclick", value: eventbox.onrightclick },
      ],
      this.indentLevel,
      eventbox.children
    );
  }

  visitRevealer(revealer: Revealer): void {
    this.yuck = _widget(
      revealer,
      [
        { key: "transition", value: revealer.transition },
        { key: "reveal", value: revealer.reveal },
        { key: "duration", value: revealer.duration },
      ],
      this.indentLevel,
      revealer.children
    );
  }

  visitFor(fo: For): void {
    const childVisitor = new YuckVisitor();
    childVisitor.indentLevel = this.indentLevel + 1;
    fo.child.accept(childVisitor);
    this.yuck = `
${_padder(this.indentLevel)}(${fo.name} ${fo.for} in ${fo.in}
${childVisitor.yuck}
${_padder(this.indentLevel)}) 
`;
  }

  visitDefWidget(defwidget: DefWidget) {
    const childVisitor = new YuckVisitor();
    childVisitor.indentLevel = this.indentLevel + 1;
    defwidget.child.accept(childVisitor);
    this.yuck = `
(defwidget ${defwidget.name} []
${childVisitor.yuck}
)
`.replace(/^\s*\n/gm, "");
  }

  visitDefWindow(defwindow: DefWindow) {
    const indent = _padder(this.indentLevel + 1);
    const indentGeom = _padder(this.indentLevel + 2);
    const childVisitor = new YuckVisitor();
    childVisitor.indentLevel = this.indentLevel + 2;
    defwindow.child.accept(childVisitor);
    this.yuck = `
(defwindow ${defwindow.name}
${indent}${_property("monitor", defwindow.monitor)}
${indent}:geometry (geometry
${indentGeom}${_property("x", defwindow.geometry.x)}
${indentGeom}${_property("y", defwindow.geometry.y)}
${indentGeom}${_property("width", defwindow.geometry.width)}
${indentGeom}${_property("height", defwindow.geometry.height)}
${indentGeom}${_property("anchor", defwindow.geometry.anchor)}
${indent})
${indent}${_property("exclusive", defwindow.exclusive)}
${indent}${_property("stacking", defwindow.stacking)}
${indent}${_property("namepsace", defwindow.namepsace)}
${childVisitor.yuck}
)
`.replace(/^\s*\n/gm, "");
  }
  visitCustom(custom: Custom): void {
    this.yuck = `
${_padder(this.indentLevel - 1)}(${custom.name})
    `;
  }
}
