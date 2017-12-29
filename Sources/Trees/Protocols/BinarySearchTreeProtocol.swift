//
//  BinarySearchTreeProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/17/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A binary tree that subscribes to the following set of rules:
/// - Any node to a node's left is "less than" that node.
/// - Any node to a node's right is "greater than" that node.
public protocol BinarySearchTreeProtocol: SingleTypeBinaryTreeProtocol where Node: Comparable {
    /// Creates a new, empty tree.
    init()

    /// Returns the node containing the element if it appears in the tree, or nil if it does not.
    /// - Parameter element: The element to find in the tree.
    /// - Returns: The node containing the element if it appears in the tree, or nil if it does not.
    func search(for element: Element) -> Self?

    /// Returns a boolean value indicating whether the element appears in the tree.
    /// - Parameter element: The element to search for.
    /// - Returns: A boolean value indicating whether the element appears in the tree.
    func contains(_ element: Element) -> Bool

    /// Inserts the element into the tree.
    /// - Parameter element: The element to insert into the tree.
    mutating func insert(_ element: Element)
}

// MARK: - Default implementations

extension BinarySearchTreeProtocol {
    public func search(for element: Element) -> Self? {
        guard let value = value else { return nil }
        if element < value {
            return left?.search(for: element)
        } else if element > value {
            return right?.search(for: element)
        } else {
            return self
        }
    }

    public func contains(_ element: Element) -> Bool {
        return search(for: element) != nil
    }
}

// MARK: - Initializers

extension BinarySearchTreeProtocol {
    public init<S: Sequence>(_ source: S) where S.Element == Element {
        self = source.reduce(into: .init()) { $0.insert($1) }
    }
}

// MARK: - Methods

extension BinarySearchTreeProtocol {
    /// Returns the minimum element in the tree, or nil if the tree is empty.
    /// - Returns: The minimum element in the tree, or nil if the tree is empty.
    public func min() -> Element? {
        if let left = left {
            return left.min()
        } else {
            return value
        }
    }

    /// Returns the maximum element in the tree, or nil if the tree is empty.
    /// - Returns: The maximum element in the tree, or nil if the tree is empty.
    public func max() -> Element? {
        if let right = right {
            return right.max()
        } else {
            return value
        }
    }
}
