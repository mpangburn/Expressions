//
//  NeverEmptyTreeProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/17/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A tree that cannot be empty.
public protocol NeverEmptyTreeProtocol: TreeProtocol { }

extension NeverEmptyTreeProtocol {
    /// The kind of the tree--either a leaf or a non-leaf node--safely unwrapped, as the tree cannot be empty.
    /// The enum case's associated value contains the node's data.
    public var safeKind: TreeNode<Leaf, Node> {
        guard let kind = kind else { fatalError("The tree cannot be empty.") }
        return kind
    }
}
