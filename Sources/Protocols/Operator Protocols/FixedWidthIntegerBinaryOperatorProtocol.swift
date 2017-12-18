//
//  FixedWidthIntegerBinaryOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public protocol FixedWidthIntegerBinaryOperatorProtocol: BinaryIntegerBinaryOperatorProtocol where Operand: FixedWidthInteger {
    init(identifier: String, apply: @escaping (Operand, Operand) -> Operand, precedence: NumericBinaryOperatorPrecedence,
         associativity: BinaryOperatorAssociativity, isCommutative: Bool)
    static var addIgnoringOverflow: Self { get }
    static var subtractIgnoringOverflow: Self { get }
    static var multiplyIgnoringOverflow: Self { get }
    static var bitwiseLeftMaskingShift: Self { get }
    static var bitwiseRightMaskingShift: Self { get }
}

extension FixedWidthIntegerBinaryOperatorProtocol {
    public static var addIgnoringOverflow: Self { return Self.init(identifier: "&+", apply: &+, precedence: .addition, associativity: .left, isCommutative: true) }
    public static var subtractIgnoringOverflow: Self { return Self.init(identifier: "&-", apply: &-, precedence: .addition, associativity: .left, isCommutative: true) }
    public static var multiplyIgnoringOverflow: Self { return Self.init(identifier: "&*", apply: &*, precedence: .multiplication, associativity: .left, isCommutative: true) }
    public static var bitwiseLeftMaskingShift: Self { return Self.init(identifier: "&<<", apply: &<<, precedence: .bitwiseShift, associativity: .none, isCommutative: false) }
    public static var bitwiseRightMaskingShift: Self { return Self.init(identifier: "&>>", apply: &>>, precedence: .bitwiseShift, associativity: .none, isCommutative: false) }
}
