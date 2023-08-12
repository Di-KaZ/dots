import { Widget, WidgetProps } from "./widget";
import { NodeVisitor } from "../node_visitor";

export interface BoxProps extends WidgetProps {
  spacing?: number;
  orientation?: "vertical" | "horizontal" | "v" | "h";
  spaceEvenly?: boolean;
  children?: Widget[];
}

export class Box extends Widget implements BoxProps {
  comment?: string;
  children: Widget[];
  spacing?: number;
  orientation?: "vertical" | "horizontal" | "v" | "h";
  spaceEvenly?: boolean;

  constructor(props: BoxProps) {
    super("box", props);
    this.children = props.children ?? [];
    this.spacing = props.spacing;
    this.orientation = props.orientation;
    this.spaceEvenly = props.spaceEvenly;
  }

  accept(visitor: NodeVisitor): void {
    visitor.visitBox(this);
  }
}
