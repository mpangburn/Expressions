//
//  RedBlackTree.swift
//  Expression
//
//  Created by Michael Pangburn on 12/17/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import UIKit


/// A self-balancing binary search tree following traditional red-black tree rules.
/// c.f. https://airspeedvelocity.net/2015/07/22/a-persistent-tree-using-indirect-enums-in-swift/
public enum RedBlackTree<Element: Comparable>: BinarySearchTreeProtocol, SingleTypeTreeProtocol {
    public enum Color { case red, black }
    
    case empty
    indirect case node(color: Color, left: RedBlackTree<Element>, value: Element, right: RedBlackTree<Element>)

    // MARK: Public

    public init() {
        self = .empty
    }

    public mutating func insert(_ element: Element) {
        self = withInserted(element)
    }

    // MARK: Private

    private init(value: Element, color: Color = .black, left: RedBlackTree<Element> = .empty, right: RedBlackTree<Element> = .empty) {
        self = .node(color: color, left: left, value: value, right: right)
    }

    private func withInserted(_ element: Element) -> RedBlackTree<Element> {
        guard case let .node(_, left, value, right) = insertHelper(element) else {
            fatalError("A tree can never be empty after an insertion.")
        }

        return .node(color: .black, left: left, value: value, right: right)
    }

    private func insertHelper(_ element: Element) -> RedBlackTree<Element> {
        guard case let .node(color, left, value, right) = self else {
            return RedBlackTree(value: element, color: .red)
        }

        if element < value {
            return RedBlackTree(value: value, color: color, left: left.insertHelper(element), right: right).rebalanced()
        } else if element > value {
            return RedBlackTree(value: value, color: color, left: left, right: right.insertHelper(element)).rebalanced()
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
    public var kind: Either<Element, Element>? {
        guard case let .node(_, left, value, right) = self else { return nil }
        if left.isEmpty, right.isEmpty {
            return .leaf(value)
        } else {
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

// MARK: - Visual attributes

extension RedBlackTree: CustomPlaygroundQuickLookableBinaryTreeProtocol {
    public var visualAttributes: NodeVisualAttributes? {
        guard case let .node(color, _, value, _) = self else { return nil }
        let uiColor: UIColor
        switch color {
        case .red:
            uiColor = .red
        case .black:
            uiColor = .black
        }

        let text = String(describing: value)
        let textAttributes = NodeVisualAttributes.SingleTypeTree.nodeTextAttributes

        return NodeVisualAttributes(color: uiColor, text: text, textAttributes: textAttributes, connectingLineColor: uiColor)
    }
}
