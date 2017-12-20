//
//  TreeNode.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// The kind of a tree node--either a leaf or a non-leaf node.
/// The enum case's associated value contains the node's data.
public enum TreeNode<A: Equatable, B: Equatable> { // TODO: Remove Equatable dependency with conditional conformance
    case leaf(A)
    case node(B)
}

extension TreeNode: Equatable /* where A: Equatable, B: Equatable */ {
    public static func == <A, B> (lhs: TreeNode<A, B>, rhs: TreeNode<A, B>) -> Bool {
        switch (lhs, rhs) {
        case let (.leaf(leftValue), .leaf(rightValue)):
            return leftValue == rightValue
        case let (.node(leftValue), .node(rightValue)):
            return leftValue == rightValue
        case (.leaf, .node):
            return false
        case (.node, .leaf):
            return false
        }
    }
}
