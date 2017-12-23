//
//  SingleTypeBinaryTreeProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/17/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A binary tree whose leaf and non-leaf nodes contain values of the same type.
public protocol SingleTypeBinaryTreeProtocol: SingleTypeTreeProtocol, BinaryTreeProtocol { }

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
}
