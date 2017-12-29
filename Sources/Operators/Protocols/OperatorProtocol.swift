//
//  OperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A type that can perform an operation on another.
public protocol OperatorProtocol: Equatable, CustomStringConvertible {
    /// The type on which the operation is performed.
    associatedtype Operand

    /// The type returned by the operation.
    associatedtype Result

    /// The string identifying the operator.
    var identifier: String { get }
}

// MARK: - Default implementations

extension OperatorProtocol {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

extension OperatorProtocol {
    public var description: String {
        return identifier
    }
}
