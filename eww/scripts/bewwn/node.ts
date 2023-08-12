import { NodeVisitor as NodeVisitor } from "./node_visitor";

export abstract class Node {
  name: string;

  constructor(name: string) {
    this.name = name;
  }

  abstract accept(visitor: NodeVisitor): void;
}
