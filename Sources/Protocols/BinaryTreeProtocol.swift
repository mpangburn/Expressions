//
//  BinaryTreeProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/15/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public protocol BinaryTreeProtocol: TreeProtocol {
    var left: Self? { get }
    var right: Self? { get }
}

extension BinaryTreeProtocol {
    public var children: [Self] {
        return [left, right].flatMap { $0 }
    }
}

extension BinaryTreeProtocol {
    public func traverseInOrder(process: (Kind) -> Void) {
        guard let kind = kind else { return }
        left.map { $0.traverseInOrder(process: process) }
        process(kind)
        right.map { $0.traverseInOrder(process: process) }
    }
}
