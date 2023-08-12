import { Widget, WidgetProps } from "./widget";
import { NodeVisitor } from "../node_visitor";

export interface EventBoxProps extends WidgetProps {
  timeout?: string;
  onscroll?: string;
  onhover?: string;
  onhoverlost?: string;
  cursor?: string;
  ondropped?: string;
  dragvalue?: string;
  dragtype?: string;
  onclick?: string;
  onmiddleclick?: string;
  onrightclick?: string;
  children?: Widget[];
}

export class EventBox extends Widget implements EventBoxProps {
  timeout?: string;
  onscroll?: string;
  onhover?: string;
  onhoverlost?: string;
  cursor?: string;
  ondropped?: string;
  dragvalue?: string;
  dragtype?: string;
  onclick?: string;
  onmiddleclick?: string;
  onrightclick?: string;
  children: Widget[];

  constructor(props: EventBoxProps) {
    super("eventbox", props);
    this.timeout = props.timeout;
    this.onscroll = props.onscroll;
    this.onhover = props.onhover;
    this.onhoverlost = props.onhoverlost;
    this.cursor = props.cursor;
    this.ondropped = props.ondropped;
    this.dragvalue = props.dragvalue;
    this.dragtype = props.dragtype;
    this.onclick = props.onclick;
    this.onmiddleclick = props.onmiddleclick;
    this.onrightclick = props.onrightclick;
    this.children = props.children ?? [];
  }

  accept(visitor: NodeVisitor): void {
    visitor.visitEventBox(this);
  }
}
