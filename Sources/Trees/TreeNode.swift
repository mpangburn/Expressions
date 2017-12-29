//
//  TreeNode.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// The kind of a tree node--empty, a leaf node, or a non-leaf node.
/// In either node case, the associated value contains the node's data.
public enum TreeNode<A, B> {
    case empty
    case leaf(A)
    case node(B)
}
