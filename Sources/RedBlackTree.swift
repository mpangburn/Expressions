//
//  RedBlackTree.swift
//  Expression
//
//  Created by Michael Pangburn on 12/17/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import UIKit


// c.f. https://airspeedvelocity.net/2015/07/22/a-persistent-tree-using-indirect-enums-in-swift/
public enum RedBlackTree<Element: Comparable>: BinarySearchTreeProtocol, SingleTypeCustomPlaygroundQuickLookableBinaryTreeProtocol {

    public enum Color { case red, black }

    case empty
    indirect case node(color: Color, left: RedBlackTree<Element>, value: Element, right: RedBlackTree<Element>)

    public init() {
        self = .empty
    }

    public init(value: Element, color: Color = .black, left: RedBlackTree<Element> = .empty, right: RedBlackTree<Element> = .empty) {
        self = .node(color: color, left: left, value: value, right: right)
    }

    public mutating func insert(_ element: Element) {
        self = withInserted(element)
    }

    public func withInserted(_ element: Element) -> RedBlackTree<Element> {
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
            return RedBlackTree(value: value, color: color, left: left.insertHelper(element), right: right).balanced()
        } else if element > value {
            return RedBlackTree(value: value, color: color, left: left, right: right.insertHelper(element)).balanced()
        } else {
            return self
        }
    }

    private func balanced() -> RedBlackTree<Element> {
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

extension RedBlackTree {
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

// MARK: - ExpressibleByArrayLiteral

extension RedBlackTree: ExpressibleByArrayLiteral {
    public init<S: Sequence>(_ source: S) where S.Element == Element {
        self = source.reduce(RedBlackTree()) { $0.withInserted($1) }
    }

    public init(arrayLiteral elements: Element...) {
        self = RedBlackTree(elements)
    }
}

// MARK: - Required conformance to tree protocols

extension RedBlackTree {
    public var kind: Either<Element, Element>? {
        guard case let .node(_, left, value, right) = self else { return nil }
        if left == .empty && right == .empty {
            return .leaf(value)
        } else {
            return .node(value)
        }
    }

    public var left: RedBlackTree<Element>? {
        guard case let .node(_, left, _, _) = self else { return nil }
        guard left != .empty else { return nil }
        return left
    }

    public var right: RedBlackTree<Element>? {
        guard case let .node(_, _, _, right) = self else { return nil }
        guard right != .empty else { return nil }
        return right
    }
}
