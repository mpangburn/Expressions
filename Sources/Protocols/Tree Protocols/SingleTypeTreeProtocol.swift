//
//  SingleTypeTreeProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/17/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A tree whose leaf and non-leaf nodes contain values of the same type.
public protocol SingleTypeTreeProtocol: TreeProtocol where Leaf == Node {

    /// The single type of element contained by the tree.
    typealias Element = Node
}

// MARK: - Computed properties

extension SingleTypeTreeProtocol {

    /// The value of the node.
    /// This property is nil if the tree is empty.
    public var value: Element? {
        guard let kind = kind else { return nil }
        switch kind {
        case let .leaf(value):
            return value
        case let .node(value):
            return value
        }
    }
}

// MARK: - Methods

extension SingleTypeTreeProtocol {

    /// Processes the node, then each of its children recursively.
    /// - Parameters:
    ///     - process: The process to apply to each node.
    ///     - element: The data contained by the node.
    public func traversePreOrder(process: (_ element: Element) -> Void) {
        guard let value = value else { return }
        process(value)
        children.forEach { $0.traversePreOrder(process: process) }
    }

    /// Returns a list containing the tree's elements as traversed in pre-order fashion,
    /// i.e. with the current node appended, then each of its children recursively.
    /// - Returns: A list containing the tree's elements as traversed in pre-order fashion.
    public func traversedPreOrder() -> [Element] {
        var elements: [Element] = []
        traversePreOrder() { elements.append($0) }
        return elements
    }

    /// Processes each of the node's children recursively, then itself.
    /// - Parameters:
    ///     - process: The process to apply to each node.
    ///     - element: The data contained by the node.
    public func traversePostOrder(process: (_ element: Element) -> Void) {
        guard let value = value else { return }
        children.forEach { $0.traversePostOrder(process: process) }
        process(value)
    }

    /// Returns a list containing the tree's elements as traversed in post-order fashion,
    /// i.e. with each of the node's children appended recursively, then itself.
    /// - Returns: A list containing the tree's elements as traversed in post-order fashion.
    public func traversedPostOrder() -> [Element] {
        var elements: [Element] = []
        traversePostOrder() { elements.append($0) }
        return elements
    }

    /// Processes every node on a level, left-to-right, before continuing to the next level.
    /// In other words, performs a breadth-first search.
    /// - Parameters:
    ///     - process: The process to apply to each node.
    ///     - element: The data contained by the node.
    public func traverseLevelOrder(process: (_ element: Element) -> Void) {
        var queue = [self]
        while !queue.isEmpty {
            let nextNode = queue.removeFirst()
            guard let value = nextNode.value else { return }
            process(value)
            queue += nextNode.children
        }
    }

    /// Returns a list containing the tree's elements as traversed in level-order fashion,
    /// i.e. with every node on a level appended, left-to-right, before continuing to the next level.
    /// - Returns: A list containing the tree's elements as traversed in level-order fashion.
    public func traversedLevelOrder() -> [Element] {
        var elements: [Element] = []
        traverseLevelOrder() { elements.append($0) }
        return elements
    }
}
