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

    /// The kind of the tree node--either a leaf or a non-leaf node.
    /// The enum case's associated value contains the node's data.
    /// This property is nil if the tree is empty.
    var kind: TreeNode<Leaf, Node>? { get }

    /// A list containing the tree's children in the order of leftmost to rightmost.
    /// If the list is empty, the node is either a leaf or the tree is empty.
    var children: [Self] { get }
}

// MARK: - Computed properties

extension TreeProtocol {
    /// A boolean value indicating whether the tree is empty.
    public var isEmpty: Bool {
        return kind == nil
    }

    /// The number of nodes in the tree.
    public var count: Int {
        return 1 + children.map({ $0.count }).reduce(0, +)
    }

    /// The zero-based height of the tree, i.e. the length of the longest path from this node to a leaf.
    public var height: Int {
        switch kind {
        case nil, .some(.leaf):
            return 0
        case .some(.node):
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
        guard let kind = kind else { return }
        process(kind)
        children.forEach { $0.traversePreOrder(process: process) }
    }

    /// Returns a list containing the tree's nodes as traversed in pre-order fashion,
    /// i.e. with the current node appended, then each of its children recursively.
    /// - Returns: A list containing the tree's nodes as traversed in pre-order fashion.
    public func traversedPreOrder() -> [TreeNode<Leaf, Node>] {
        var elements: [TreeNode<Leaf, Node>] = []
        traversePreOrder() { elements.append($0) }
        return elements
    }

    /// Processes each of the node's children recursively, then itself.
    /// - Parameters:
    ///     - process: The process to apply to each node.
    ///     - kind: The kind of the node, which contains its data.
    public func traversePostOrder(process: (_ kind: TreeNode<Leaf, Node>) -> Void) {
        guard let kind = kind else { return }
        children.forEach { $0.traversePostOrder(process: process) }
        process(kind)
    }

    /// Returns a list containing the tree's nodes as traversed in post-order fashion,
    /// i.e. with each of the node's children appended recursively, then itself.
    /// - Returns: A list containing the tree's nodes as traversed in post-order fashion.
    public func traversedPostOrder() -> [TreeNode<Leaf, Node>] {
        var elements: [TreeNode<Leaf, Node>] = []
        traversePostOrder() { elements.append($0) }
        return elements
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
            guard let kind = nextNode.kind else { return }
            process(kind)
            queue += nextNode.children
        }
    }

    /// Returns a list containing the tree's nodes as traversed in level-order fashion,
    /// i.e. with every node on a level appended, left-to-right, before continuing to the next level.
    /// - Returns: A list containing the tree's nodes as traversed in level-order fashion.
    public func traversedLevelOrder() -> [TreeNode<Leaf, Node>] {
        var elements: [TreeNode<Leaf, Node>] = []
        traverseLevelOrder() { elements.append($0) }
        return elements
    }
}

extension TreeProtocol where Self: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.kind == rhs.kind && lhs.children == rhs.children
    }
}
