//
//  NeverEmptyTreeNode.swift
//  Expression
//
//  Created by Michael Pangburn on 12/22/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// The kind of a tree node--either a leaf node or a non-leaf node.
/// The enum case's associated value contains the node's data.
public enum NeverEmptyTreeNode<A: Equatable, B: Equatable> { // TODO: Remove Equatable dependency with conditional conformance
    case leaf(A)
    case node(B)
}

extension NeverEmptyTreeNode: Equatable /* where A: Equatable, B: Equatable */ {
    public static func == <A, B> (lhs: NeverEmptyTreeNode<A, B>, rhs: NeverEmptyTreeNode<A, B>) -> Bool {
        switch (lhs, rhs) {
        case let (.leaf(leftValue), .leaf(rightValue)):
            return leftValue == rightValue
        case let (.node(leftValue), .node(rightValue)):
            return leftValue == rightValue
        case (.leaf, _), (.node, _):
            return false
        }
    }
}
