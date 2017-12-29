//
//  BinaryIntegerBinaryOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A binary operator that operates on binary integer types.
public protocol BinaryIntegerBinaryOperatorProtocol: DivisibleBinaryOperatorProtocol where Operand: BinaryInteger {
    /// The remainder operator (%).
    static var remainder: Self { get }

    // The bitwise AND operator (&).
    static var bitwiseAND: Self { get }

    /// The bitwise OR operator (|).
    static var bitwiseOR: Self { get }

    /// The bitwise XOR operator (^).
    static var bitwiseXOR: Self { get }

    /// The bitwise left shift operator (<<).
    static var bitwiseLeftShift: Self { get }

    /// The bitwise right shift operator (>>).
    static var bitwiseRightShift: Self { get }
}

// MARK: - Default implementations

extension BinaryIntegerBinaryOperatorProtocol {
    public static var remainder: Self { return .init(identifier: "%", apply: %, precedence: .multiplication, associativity: .left, isCommutative: false) }
    public static var bitwiseAND: Self { return .init(identifier: "&", apply: &, precedence: .multiplication, associativity: .left, isCommutative: true) }
    public static var bitwiseOR: Self { return .init(identifier: "|", apply: |, precedence: .addition, associativity: .left, isCommutative: true) }
    public static var bitwiseXOR: Self { return .init(identifier: "^", apply: ^, precedence: .addition, associativity: .left, isCommutative: true) }
    public static var bitwiseLeftShift: Self { return .init(identifier: "<<", apply: <<, precedence: .bitwiseShift, associativity: .none, isCommutative: false) }
    public static var bitwiseRightShift: Self { return .init(identifier: ">>", apply: >>, precedence: .bitwiseShift, associativity: .none, isCommutative: false) }
}
