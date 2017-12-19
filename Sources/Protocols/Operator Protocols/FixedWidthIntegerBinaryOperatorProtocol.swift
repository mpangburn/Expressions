//
//  FixedWidthIntegerBinaryOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A binary operator that operates on fixed width integers.
public protocol FixedWidthIntegerBinaryOperatorProtocol: BinaryIntegerBinaryOperatorProtocol where Operand: FixedWidthInteger {
    init(identifier: String, apply: @escaping (Operand, Operand) -> Operand, precedence: BinaryOperatorPrecedence,
         associativity: BinaryOperatorAssociativity, isCommutative: Bool)

    /// The addition operation, ignoring overflow (&+).
    static var addIgnoringOverflow: Self { get }

    /// The subtraction operation, ignoring overflow (&-).
    static var subtractIgnoringOverflow: Self { get }

    /// The multiplication operation, ignoring overflow (&*).
    static var multiplyIgnoringOverflow: Self { get }

    /// The bitwise left masking shift operator (&<<).
    static var bitwiseLeftMaskingShift: Self { get }

    /// The bitwise right masking shift operator (&>>).
    static var bitwiseRightMaskingShift: Self { get }
}

// MARK: - Default implementations

extension FixedWidthIntegerBinaryOperatorProtocol {
    public static var addIgnoringOverflow: Self { return Self.init(identifier: "&+", apply: &+, precedence: .addition, associativity: .left, isCommutative: true) }
    public static var subtractIgnoringOverflow: Self { return Self.init(identifier: "&-", apply: &-, precedence: .addition, associativity: .left, isCommutative: true) }
    public static var multiplyIgnoringOverflow: Self { return Self.init(identifier: "&*", apply: &*, precedence: .multiplication, associativity: .left, isCommutative: true) }
    public static var bitwiseLeftMaskingShift: Self { return Self.init(identifier: "&<<", apply: &<<, precedence: .bitwiseShift, associativity: .none, isCommutative: false) }
    public static var bitwiseRightMaskingShift: Self { return Self.init(identifier: "&>>", apply: &>>, precedence: .bitwiseShift, associativity: .none, isCommutative: false) }
}
