//
//  TreeProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/15/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A tree whose leaf nodes and non-leaf nodes can hold values of different types.
public protocol TreeProtocol {
    /// The type contained by the tree's leaf nodes.
    associatedtype Leaf: Equatable

    /// The type contained by the tree's non-leaf nodes.
    associatedtype Node: Equatable

    /// The kind of a tree node--empty, a leaf node, or a non-leaf node.
    /// In either node case, the associated value contains the node's data.
    var nodeKind: TreeNode<Leaf, Node> { get }

    /// A list containing the tree's children in the order of leftmost to rightmost.
    /// If the list is empty, the node is either a leaf or the tree is empty.
    var children: [Self] { get }
}

// MARK: - Computed properties

extension TreeProtocol {
    /// A boolean value indicating whether the tree is empty.
    public var isEmpty: Bool {
        return nodeKind == .empty
    }

    /// The number of nodes in the tree.
    public var count: Int {
        return 1 + children.map({ $0.count }).reduce(0, +)
    }

    /// The zero-based height of the tree, i.e. the length of the longest path from this node to a leaf.
    public var height: Int {
        switch nodeKind {
        case .empty, .leaf:
            return 0
        case .node:
            return 1 + (children.map({ $0.height }).max() ?? 0)
        }
    }
}

// MARK: - Methods

extension TreeProtocol {
    /// Processes the node, then each of its children recursively.
    /// - Parameters:
    ///     - process: The process to apply to each node.
    ///     - kind: The kind of the node, which contains its data.
    public func traversePreOrder(process: (_ kind: TreeNode<Leaf, Node>) -> Void) {
        process(nodeKind)
        children.forEach { $0.traversePreOrder(process: process) }
    }

    /// Processes each of the node's children recursively, then itself.
    /// - Parameters:
    ///     - process: The process to apply to each node.
    ///     - kind: The kind of the node, which contains its data.
    public func traversePostOrder(process: (_ kind: TreeNode<Leaf, Node>) -> Void) {
        children.forEach { $0.traversePostOrder(process: process) }
        process(nodeKind)
    }

    /// Processes every node on a level, left-to-right, before continuing to the next level.
    /// In other words, performs a breadth-first search.
    /// - Parameters:
    ///     - process: The process to apply to each node.
    ///     - kind: The kind of the node, which contains its data.
    public func traverseLevelOrder(process: (_ kind: TreeNode<Leaf, Node>) -> Void) {
        var queue = [self]
        while !queue.isEmpty {
            let nextNode = queue.removeFirst()
            process(nodeKind)
            queue += nextNode.children
        }
    }
}

extension TreeProtocol where Self: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.nodeKind == rhs.nodeKind && lhs.children == rhs.children
    }
}
