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

    var kind: Kind? { get }
    var children: [Self] { get }
}

extension TreeProtocol {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.kind == rhs.kind && lhs.children == rhs.children
    }
}

extension TreeProtocol {
    public var isEmpty: Bool {
        return kind == nil
    }

    public var count: Int {
        return 1 + children.map({ $0.count }).reduce(0, +)
    }

    public var height: Int {
        guard let kind = kind else { return 0 }
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
        guard let kind = kind else { return }
        process(kind)
        children.forEach { $0.traversePreOrder(process: process) }
    }

    public func traversePostOrder(process: (Kind) -> Void) {
        guard let kind = kind else { return }
        children.forEach { $0.traversePostOrder(process: process) }
        process(kind)
    }

    public func traverseLevelOrder(process: (Kind) -> Void) {
        var queue = [self]
        while !queue.isEmpty {
            let nextNode = queue.removeFirst()
            guard let kind = nextNode.kind else { return }
            process(kind)
            queue += nextNode.children
        }
    }
}
