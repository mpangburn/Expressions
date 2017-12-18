//
//  TreeProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/15/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// Represents a tree whose leaf nodes and non-leaf nodes can hold values of different types.
public protocol TreeProtocol: Equatable {
    associatedtype Leaf: Equatable
    associatedtype Node: Equatable

    typealias Kind = Either<Leaf, Node>

    var kind: Kind { get }
    var children: [Self] { get }
}

extension TreeProtocol {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.kind == rhs.kind && lhs.children == rhs.children
    }
}

extension TreeProtocol {
    public var count: Int {
        return 1 + children.map({ $0.count }).reduce(0, +)
    }

    public var height: Int {
        switch kind {
        case .leaf:
            return 0
        case .node:
            return 1 + (children.map({ $0.height }).max() ?? 0)
        }
    }
}

extension TreeProtocol {
    public func traversePreOrder(process: (Kind) -> Void) {
        process(kind)
        children.forEach { $0.traversePreOrder(process: process) }
    }

    public func traversePostOrder(process: (Kind) -> Void) {
        children.forEach { $0.traversePostOrder(process: process) }
        process(kind)
    }

    public func traverseLevelOrder(process: (Kind) -> Void) {
        var queue = [self]
        while !queue.isEmpty {
            let nextNode = queue.removeFirst()
            process(nextNode.kind)
            queue += nextNode.children
        }
    }
}
