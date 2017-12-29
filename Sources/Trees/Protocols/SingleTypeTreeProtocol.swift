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
        switch nodeKind {
        case .empty:
            return nil
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

    /// Processes each of the node's children recursively, then itself.
    /// - Parameters:
    ///     - process: The process to apply to each node.
    ///     - element: The data contained by the node.
    public func traversePostOrder(process: (_ element: Element) -> Void) {
        guard let value = value else { return }
        children.forEach { $0.traversePostOrder(process: process) }
        process(value)
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
}
