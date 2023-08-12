import { Widget } from "./widgets/widget";
import { NodeVisitor } from "./node_visitor";
import { Node } from "./node";
import { Custom } from "./widgets/custom_widget";

export interface DefWidgetProps {
  child: Widget;
  name: string;
}

export class DefWidget extends Node implements DefWidgetProps {
  child: Widget;

  constructor(props: DefWidgetProps) {
    super(props.name);
    this.child = props.child;
  }

  accept(visitor: NodeVisitor): void {
    visitor.visitDefWidget(this);
  }

  get(): Custom {
    return new Custom({ reference: this });
  }
}
