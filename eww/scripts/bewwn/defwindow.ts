import { Widget } from "./widgets/widget";
import { NodeVisitor } from "./node_visitor";
import { Node } from "./node";

type _AnchorY = "top" | "center" | "bottom";
type _AnchorX = "left" | "center" | "right";
type Anchor = `${_AnchorY} ${_AnchorX}` | "center";

interface Geometry {
  x: string;
  y: string;
  width: string;
  height: string;
  anchor: Anchor;
}

export interface DefWindowProps {
  child: Widget;
  name: string;
  monitor: number;
  geometry: Geometry;
  exclusive: boolean;
  stacking: "fg" | "bg";
  namepsace: string;
}

export class DefWindow extends Node implements DefWindowProps {
  child: Widget;
  monitor: number;
  geometry: Geometry;
  exclusive: boolean;
  stacking: "fg" | "bg";
  namepsace: string;

  constructor(props: DefWindowProps) {
    super(props.name);
    this.child = props.child;
    this.monitor = props.monitor;
    this.geometry = props.geometry;
    this.exclusive = props.exclusive;
    this.stacking = props.stacking;
    this.namepsace = props.namepsace;
  }

  accept(visitor: NodeVisitor): void {
    visitor.visitDefWindow(this);
  }
}
