//
//  SingleTypeBinaryTreeProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/17/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A binary tree whose leaf and non-leaf nodes contain values of the same type.
public protocol SingleTypeBinaryTreeProtocol: SingleTypeTreeProtocol, BinaryTreeProtocol {

    /// The single type of element contained by the tree.
    typealias Element = Node
}

// MARK: - Methods

extension SingleTypeBinaryTreeProtocol {

    /// Processes the node's left chlid recursively, then itself, then its right child recursively.
    /// - Parameters:
    ///     - process: The process to apply to each node.
    ///     - element: The data contained by the node.
    public func traverseInOrder(process: (_ element: Element) -> Void) {
        guard let value = value else { return }
        left.map { $0.traverseInOrder(process: process) }
        process(value)
        right.map { $0.traverseInOrder(process: process) }
    }

    /// Returns a list containing the tree's elements as traversed in in-order fashion,
    /// i.e. with the node's left child appended recursively, then itself, then its right child recursively.
    /// - Returns: A list containing the tree's elements as traversed in in-order fashion.
    public func traversedInOrder() -> [Element] {
        var elements: [Element] = []
        traversePostOrder() { elements.append($0) }
        return elements
    }
}
