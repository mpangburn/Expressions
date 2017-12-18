//
//  BinarySearchTreeProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/17/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public protocol BinarySearchTreeProtocol: SingleTypeBinaryTreeProtocol where Node: Comparable {
    typealias Element = Node
    func contains(_ element: Element) -> Bool
}

extension BinarySearchTreeProtocol {
    public func contains(_ element: Element) -> Bool {
        if element < value {
            return left?.contains(element) ?? false
        } else if element > value {
            return right?.contains(element) ?? false
        } else {
            return true
        }
    }
}
