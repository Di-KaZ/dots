import { Widget } from "./widgets/widget";
import { NodeVisitor } from "./node_visitor";
import { Node } from "./node";

export interface ForProps {
  child: Widget;
  for: string;
  in: string;
}

export class For extends Node implements ForProps {
  child: Widget;
  for: string;
  in: string;

  constructor(props: ForProps) {
    super("for");
    this.child = props.child;
    this.for = props.for;
    this.in = props.in;
  }

  accept(visitor: NodeVisitor): void {
    visitor.visitFor(this);
  }
}
