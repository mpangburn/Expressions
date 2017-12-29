//
//  BinarySearchTree.swift
//  Expression
//
//  Created by Michael Pangburn on 12/19/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A traditional non-self-balancing binary search tree.
public enum BinarySearchTree<Element: Comparable>: BinarySearchTreeProtocol {
    case empty
    indirect case node(left: BinarySearchTree<Element>, value: Element, right: BinarySearchTree<Element>)

    public init() {
        self = .empty
    }

    public mutating func insert(_ element: Element) {
        self = inserting(element)
    }

    public func inserting(_ element: Element) -> BinarySearchTree<Element> {
        guard case let .node(left, value, right) = self else {
            return .node(left: .empty, value: element, right: .empty)
        }

        if element < value {
            return .node(left: left.inserting(element), value: value, right: right)
        } else if element > value {
            return .node(left: left, value: value, right: right.inserting(element))
        } else {
            return self
        }
    }

    public mutating func delete(_ element: Element) {
        self = deleting(element)
    }

    public func deleting(_ element: Element) -> BinarySearchTree<Element> {
        guard case let .node(left, value, right) = self else {
            return .empty
        }

        if element < value {
            return .node(left: left.deleting(element), value: value, right: right)
        } else if element > value {
            return .node(left: left, value: value, right: right.deleting(element))
        } else {
            switch (left, right) {
            case (.empty, .empty):
                return .empty
            case (.empty, _):
                return right
            case (_, .empty):
                return left
            default:
                guard let successor = right.min() else { fatalError("Unreachable--the right side cannot be empty.") }
                return .node(left: left, value: successor, right: right.deleting(successor))
            }
        }
    }
}

// MARK: - Required conformance to tree protocols

extension BinarySearchTree {
    public var nodeKind: TreeNode<Element, Element> {
        switch self {
        case .empty:
            return .empty
        case let .node(left, value, right) where left.isEmpty && right.isEmpty:
            return .leaf(value)
        case let .node(_, value, _):
            return .node(value)
        }
    }

    public var left: BinarySearchTree<Element>? {
        guard case let .node(left, _, _) = self, !left.isEmpty else { return nil }
        return left
    }

    public var right: BinarySearchTree<Element>? {
        guard case let .node(_, _, right) = self, !right.isEmpty else { return nil }
        return right
    }
}

// MARK: - Visual attributes

extension BinarySearchTree: CustomPlaygroundQuickLookableBinaryTreeProtocol { }
