//
//  BinaryTreeProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/15/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A tree with at most two children.
public protocol BinaryTreeProtocol: TreeProtocol {
    /// The node's left child.
    /// This property is nil if the node has no left child.
    var left: Self? { get }

    /// The node's right child.
    /// This property is nil if the node has no right child.
    var right: Self? { get }
}

// MARK: - Default implementations

extension BinaryTreeProtocol {
    /// A list containing the tree's left and right children, if present.
    public var children: [Self] {
        return [left, right].flatMap { $0 }
    }
}

// MARK: - Methods

extension BinaryTreeProtocol {
    /// Processes the node's left chlid recursively, then itself, then its right child recursively.
    /// - Parameters:
    ///     - process: The process to apply to each node.
    ///     - kind: The kind of the node, which contains its data.
    public func traverseInOrder(process: (_ kind: TreeNode<Leaf, Node> ) -> Void) {
        guard let kind = kind else { return }
        left.map { $0.traverseInOrder(process: process) }
        process(kind)
        right.map { $0.traverseInOrder(process: process) }
    }

    /// Returns a list containing the tree's nodes as traversed in in-order fashion,
    /// i.e. with the node's left child appended recursively, then itself, then its right child recursively.
    /// - Returns: A list containing the tree's nodes as traversed in in-order fashion.
    public func traversedInOrder() -> [TreeNode<Leaf, Node> ] {
        var elements: [TreeNode<Leaf, Node> ] = []
        traversePostOrder() { elements.append($0) }
        return elements
    }
}
