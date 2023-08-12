import { Node } from "../node";
import { NodeVisitor } from "../node_visitor";

export type Alignment = "fill" | "baseline" | "center" | "start" | "end";

export interface WidgetProps {
  className?: string;
  valign?: Alignment;
  halign?: Alignment;
  vexpand?: boolean;
  hexpand?: boolean;
  width?: number;
  height?: number;
  active?: boolean;
  tooltip?: string;
  visible?: boolean;
  style?: string;
  css?: string;
  comment?: string;
}

export abstract class Widget extends Node implements WidgetProps {
  className?: string | undefined;
  valign?: Alignment;
  halign?: Alignment;
  vexpand?: boolean;
  hexpand?: boolean;
  width?: number;
  height?: number;
  active?: boolean;
  tooltip?: string;
  visible?: boolean;
  style?: string;
  css?: string;
  comment?: string;

  constructor(name: string, props: WidgetProps) {
    super(name);
    this.className = props.className;
    this.valign = props.valign;
    this.halign = props.halign;
    this.vexpand = props.vexpand;
    this.hexpand = props.hexpand;
    this.width = props.width;
    this.height = props.height;
    this.active = props.active;
    this.tooltip = props.tooltip;
    this.visible = props.visible;
    this.style = props.style;
    this.css = props.css;
    this.comment = props.comment;
  }

  abstract accept(visitor: NodeVisitor): void;
}
