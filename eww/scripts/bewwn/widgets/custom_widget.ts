import { Widget, WidgetProps } from "./widget";
import { NodeVisitor } from "../node_visitor";
import { DefWidget } from "../defwidget";
import { Node } from "../node";

export interface CustomProps {
  reference: DefWidget;
}

export class Custom extends Node implements CustomProps {
  reference: DefWidget;

  constructor(props: CustomProps) {
    super(props.reference.name);
    this.reference = props.reference;
  }

  accept(visitor: NodeVisitor): void {
    visitor.visitCustom(this);
  }
}
