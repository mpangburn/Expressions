//
//  RedBlackTree.swift
//  Expression
//
//  Created by Michael Pangburn on 12/17/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


// c.f. https://airspeedvelocity.net/2015/07/22/a-persistent-tree-using-indirect-enums-in-swift/
public enum RedBlackTree<Element: Comparable>: BinarySearchTreeProtocol, SingleTypeCustomPlaygroundQuickLookableBinaryTreeProtocol {
    public typealias Node = Element

    public enum Color { case red, black }

    case leaf(color: Color, value: Element)
    indirect case node(left: RedBlackTree<Element>, color: Color, value: Element, right: RedBlackTree<Element>?)

    // TODO: the actual implementation
}

// MARK: - Boilerplate conformance
extension RedBlackTree {
    public var kind: Either<Element, Element> {
        switch self {
        case let .leaf(_, element):
            return .leaf(element)
        case let .node(_, _, element, _):
            return .node(element)
        }
    }

    public var left: RedBlackTree<Element>? {
        guard case let .node(left, _, _, _) = self else { return nil }
        return left
    }

    public var right: RedBlackTree<Element>? {
        guard case let .node(_, _, _, right) = self else { return nil }
        return right
    }
}
