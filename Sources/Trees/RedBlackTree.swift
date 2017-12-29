//
//  RedBlackTree.swift
//  Expression
//
//  Created by Michael Pangburn on 12/17/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A self-balancing binary search tree following traditional red-black tree rules.
public enum RedBlackTree<Element: Comparable>: BinarySearchTreeProtocol, SingleTypeTreeProtocol {
    public enum Color { case red, black }
    
    case empty
    indirect case node(color: Color, left: RedBlackTree<Element>, value: Element, right: RedBlackTree<Element>)

    // MARK: Public

    public init() {
        self = .empty
    }

    public mutating func insert(_ element: Element) {
        self = inserting(element)
    }

    public func inserting(_ element: Element) -> RedBlackTree<Element> {
        guard case let .node(_, left, value, right) = insertHelper(element) else {
            fatalError("A tree can never be empty after an insertion.")
        }

        return .node(color: .black, left: left, value: value, right: right)
    }

    // MARK: Private

    private func insertHelper(_ element: Element) -> RedBlackTree<Element> {
        guard case let .node(color, left, value, right) = self else {
            return .node(color: .red, left: .empty, value: element, right: .empty)
        }

        if element < value {
            return RedBlackTree.node(color: color, left: left.insertHelper(element), value: value, right: right).rebalanced()
        } else if element > value {
            return RedBlackTree.node(color: color, left: left, value: value, right: right.insertHelper(element)).rebalanced()
        } else {
            return self
        }
    }

    private func rebalanced() -> RedBlackTree<Element> {
        switch self {
        case let .node(.black, .node(.red, .node(.red, a, x, b), y, c), z, d):
            return .node(color: .red, left: .node(color: .black, left: a, value: x, right: b), value: y, right: .node(color: .black, left: c, value: z, right: d))
        case let .node(.black, .node(.red, a, x, .node(.red, b, y, c)), z, d):
            return .node(color: .red, left: .node(color: .black, left: a, value: x, right: b), value: y, right: .node(color: .black, left: c, value: z, right: d))
        case let .node(.black, a, x, .node(.red, .node(.red, b, y, c), z, d)):
            return .node(color: .red, left: .node(color: .black, left: a, value: x, right: b), value: y, right: .node(color: .black, left: c, value: z, right: d))
        case let .node(.black, a, x, .node(.red, b, y, .node(.red, c, z, d))):
            return .node(color: .red, left: .node(color: .black, left: a, value: x, right: b), value: y, right: .node(color: .black, left: c, value: z, right: d))
        default:
            return self
        }
    }
}

// MARK: - Required conformance to tree protocols

extension RedBlackTree {
    public var nodeKind: TreeNode<Element, Element> {
        switch self {
        case .empty:
            return .empty
        case let .node(_, left, value, right) where left.isEmpty && right.isEmpty:
            return .leaf(value)
        case let .node(_, _, value, _):
            return .node(value)
        }
    }

    public var left: RedBlackTree<Element>? {
        guard case let .node(_, left, _, _) = self, !left.isEmpty else { return nil }
        return left
    }

    public var right: RedBlackTree<Element>? {
        guard case let .node(_, _, _, right) = self, !right.isEmpty else { return nil }
        return right
    }
}
