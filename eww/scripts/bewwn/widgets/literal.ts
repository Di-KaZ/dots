import { Alignment, Widget, WidgetProps } from "./widget";
import { NodeVisitor } from "../node_visitor";

export interface LiteralProps extends WidgetProps {
  content: string;
}

export class Literal extends Widget implements LiteralProps {
  content: string;

  constructor(props: LiteralProps) {
    super("literal", props);
    this.content = props.content;
  }

  accept(visitor: NodeVisitor): void {
    visitor.visitLiteral(this);
  }
}
