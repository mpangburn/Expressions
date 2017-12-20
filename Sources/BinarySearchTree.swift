//
//  BinarySearchTree.swift
//  Expression
//
//  Created by Michael Pangburn on 12/19/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A non-self-balancing binary search tree.
public enum BinarySearchTree<Element: Comparable>: BinarySearchTreeProtocol {
    case empty
    indirect case node(left: BinarySearchTree<Element>, value: Element, right: BinarySearchTree<Element>)

    // MARK: Public

    public init() {
        self = .empty
    }

    public mutating func insert(_ element: Element) {
        self = withInserted(element)
    }

    public mutating func delete(_ element: Element) {
        self = withDeleted(element)
    }

    // MARK: Private

    private func withInserted(_ element: Element) -> BinarySearchTree<Element> {
        guard case let .node(left, value, right) = self else {
            return .node(left: .empty, value: element, right: .empty)
        }

        if element < value {
            return .node(left: left.withInserted(element), value: value, right: right)
        } else if element > value {
            return .node(left: left, value: value, right: right.withInserted(element))
        } else {
            return self
        }
    }

    private func withDeleted(_ element: Element) -> BinarySearchTree<Element> {
        guard case let .node(left, value, right) = self else {
            return .empty
        }

        if element < value {
            return .node(left: left.withDeleted(element), value: value, right: right)
        } else if element > value {
            return .node(left: left, value: value, right: right.withDeleted(element))
        } else {
            switch (left, right) {
            case (.empty, .empty):
                return .empty
            case (.empty, _):
                return right
            case (_, .empty):
                return left
            default:
                guard let successor = right.min() else { fatalError("Unreachable switch case") }
                return .node(left: left, value: successor, right: right.withDeleted(successor))
            }
        }
    }
}

// MARK: - Required conformance to tree protocols

extension BinarySearchTree {
    public var kind: TreeNode<Element, Element>? {
        guard case let .node(left, value, right) = self else { return nil }
        if left.isEmpty, right.isEmpty {
            return .leaf(value)
        } else {
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
