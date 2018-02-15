//
//  NeverEmptyTreeNode.swift
//  Expression
//
//  Created by Michael Pangburn on 12/22/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

/// The kind of a tree node--either a leaf node or a non-leaf node.
/// The enum case's associated value contains the node's data.
public enum NeverEmptyTreeNode<A, B> {
    case leaf(A)
    case node(B)
}
