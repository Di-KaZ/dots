import { Widget, WidgetProps } from "./widget";
import { NodeVisitor } from "../node_visitor";

type Transition =
  | "slideright"
  | "slideleft"
  | "slideup"
  | "slidedown"
  | "crossfade"
  | "none";

export interface RevealerProps extends WidgetProps {
  transition: Transition;
  reveal?: boolean;
  duration?: string;
  children?: Widget[];
}

export class Revealer extends Widget implements RevealerProps {
  transition: Transition;
  reveal?: boolean;
  duration?: string;
  children: Widget[];

  constructor(props: RevealerProps) {
    super("revealer", props);
    this.transition = props.transition;
    this.reveal = props.reveal;
    this.duration = props.duration;
    this.children = props.children ?? [];
  }

  accept(visitor: NodeVisitor): void {
    visitor.visitRevealer(this);
  }
}
