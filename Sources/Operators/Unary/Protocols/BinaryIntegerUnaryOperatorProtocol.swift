//
//  BinaryIntegerUnaryOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/27/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A unary operator for performing arithmetic on binary integer types.
public protocol BinaryIntegerUnaryOperatorProtocol: NumericUnaryOperatorProtocol where Operand: BinaryInteger {
    /// The bitwise NOT operator (~).
    static var bitwiseNOT: Self { get }
}

// MARK: - Default implementations

extension BinaryIntegerUnaryOperatorProtocol {
    public static var bitwiseNOT: Self { return .init(identifier: "~", apply: ~) }
}
