//
//  SingleTypeBinaryTreeProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/17/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public protocol SingleTypeBinaryTreeProtocol: SingleTypeTreeProtocol, BinaryTreeProtocol {
    typealias Element = Node
}

extension SingleTypeBinaryTreeProtocol {
    public func traverseInOrder(process: (Element) -> Void) {
        left.map { $0.traverseInOrder(process: process) }
        process(value)
        right.map { $0.traverseInOrder(process: process) }
    }
}

public enum SingleTypeBinaryTree<T: Equatable>: SingleTypeCustomPlaygroundQuickLookableBinaryTreeProtocol {
    case leaf(T)
    indirect case node(left: SingleTypeBinaryTree<T>, value: T, right: SingleTypeBinaryTree<T>?)

    public var kind: Either<T, T> {
        switch self {
        case let .leaf(v): return .leaf(v)
        case let .node(_, v, _): return .node(v)
        }
    }

    public var left: SingleTypeBinaryTree? {
        guard case let .node(left, _, _) = self else { return nil }
        return left
    }

    public var right: SingleTypeBinaryTree? {
        guard case let .node(_, _, right) = self else { return nil }
        return right
    }
}

