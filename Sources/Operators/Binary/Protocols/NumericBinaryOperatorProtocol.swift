//
//  NumericBinaryOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A binary operator that operates on numeric types.
public protocol NumericBinaryOperatorProtocol: BinaryOperatorProtocol where Operand: Numeric & _ExpressibleByBuiltinIntegerLiteral, Result == Operand { }

// MARK: - Operators

extension NumericBinaryOperatorProtocol {
    public static var add: Self { return .init(identifier: "+", apply: +, precedence: .addition, associativity: .left, isCommutative: true) }
    public static var subtract: Self { return .init(identifier: "-", apply: -, precedence: .addition, associativity: .left, isCommutative: false) }
    public static var multiply: Self { return .init(identifier: "*", apply: *, precedence: .multiplication, associativity: .left, isCommutative: true) }
}

extension NumericBinaryOperatorProtocol where Operand: Divisible {
    public static var divide: Self { return .init(identifier: "/", apply: /, precedence: .multiplication, associativity: .left, isCommutative: false) }
}

extension NumericBinaryOperatorProtocol where Operand: BinaryInteger {
    public static var remainder: Self { return .init(identifier: "%", apply: %, precedence: .multiplication, associativity: .left, isCommutative: false) }
    public static var bitwiseAND: Self { return .init(identifier: "&", apply: &, precedence: .multiplication, associativity: .left, isCommutative: true) }
    public static var bitwiseOR: Self { return .init(identifier: "|", apply: |, precedence: .addition, associativity: .left, isCommutative: true) }
    public static var bitwiseXOR: Self { return .init(identifier: "^", apply: ^, precedence: .addition, associativity: .left, isCommutative: true) }
    public static var bitwiseLeftShift: Self { return .init(identifier: "<<", apply: <<, precedence: .bitwiseShift, associativity: .none, isCommutative: false) }
    public static var bitwiseRightShift: Self { return .init(identifier: ">>", apply: >>, precedence: .bitwiseShift, associativity: .none, isCommutative: false) }
}

extension NumericBinaryOperatorProtocol where Operand: FixedWidthInteger {
    public static var addIgnoringOverflow: Self { return .init(identifier: "&+", apply: &+, precedence: .addition, associativity: .left, isCommutative: true) }
    public static var subtractIgnoringOverflow: Self { return .init(identifier: "&-", apply: &-, precedence: .addition, associativity: .left, isCommutative: true) }
    public static var multiplyIgnoringOverflow: Self { return .init(identifier: "&*", apply: &*, precedence: .multiplication, associativity: .left, isCommutative: true) }
    public static var bitwiseLeftMaskingShift: Self { return .init(identifier: "&<<", apply: &<<, precedence: .bitwiseShift, associativity: .none, isCommutative: false) }
    public static var bitwiseRightMaskingShift: Self { return .init(identifier: "&>>", apply: &>>, precedence: .bitwiseShift, associativity: .none, isCommutative: false) }
}
