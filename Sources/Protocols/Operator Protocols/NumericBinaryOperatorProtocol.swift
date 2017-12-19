//
//  NumericBinaryOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A binary operator that operates on numeric types.
public protocol NumericBinaryOperatorProtocol: BinaryOperatorProtocol where Operand: Numeric & Comparable & _ExpressibleByBuiltinIntegerLiteral, Result == Operand {
    /// The addition operator (+).
    static var add: Self { get }

    /// The subtraction operator (-).
    static var subtract: Self { get }

    /// The multiplication operator (*).
    static var multiply: Self { get }
}

// MARK: - Default implementations

extension NumericBinaryOperatorProtocol {
    public static var add: Self { return Self(identifier: "+", apply: +, precedence: .addition, associativity: .left, isCommutative: true) }
    public static var subtract: Self { return Self(identifier: "-", apply: -, precedence: .addition, associativity: .left, isCommutative: false) }
    public static var multiply: Self { return Self(identifier: "*", apply: *, precedence: .multiplication, associativity: .left, isCommutative: true) }
}
