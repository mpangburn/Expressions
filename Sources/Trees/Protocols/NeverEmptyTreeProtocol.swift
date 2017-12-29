//
//  NeverEmptyTreeProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/17/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A tree that cannot be empty.
public protocol NeverEmptyTreeProtocol: TreeProtocol {
    /// The kind of a tree node--either a leaf node or a non-leaf node.
    /// The enum case's associated value contains the node's data.
    var neverEmptyNodeKind: NeverEmptyTreeNode<Leaf, Node> { get }
}

extension NeverEmptyTreeProtocol {
    public var nodeKind: TreeNode<Leaf, Node> {
        switch neverEmptyNodeKind {
        case let .leaf(value):
            return .leaf(value)
        case let .node(value):
            return .node(value)
        }
    }
}
