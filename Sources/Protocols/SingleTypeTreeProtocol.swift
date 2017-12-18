//
//  SingleTypeTreeProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/17/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public protocol SingleTypeTreeProtocol: TreeProtocol where Leaf == Node {
    typealias Element = Node
}

extension SingleTypeTreeProtocol {
    public var value: Element {
        switch kind {
        case let .leaf(val):
            return val
        case let .node(val):
            return val
        }
    }
}

extension SingleTypeTreeProtocol {
    public func traversePreOrder(process: (Element) -> Void) {
        process(value)
        children.forEach { $0.traversePreOrder(process: process) }
    }

    public func traversePostOrder(process: (Element) -> Void) {
        children.forEach { $0.traversePostOrder(process: process) }
        process(value)
    }

    public func traverseLevelOrder(process: (Element) -> Void) {
        var queue = [self]
        while !queue.isEmpty {
            let nextNode = queue.removeFirst()
            process(nextNode.value)
            queue += nextNode.children
        }
    }
}
