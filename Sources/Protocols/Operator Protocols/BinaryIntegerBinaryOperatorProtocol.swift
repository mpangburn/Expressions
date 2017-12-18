//
//  BinaryIntegerBinaryOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public protocol BinaryIntegerBinaryOperatorProtocol: DivisibleBinaryOperatorProtocol where Operand: BinaryInteger {
    init(identifier: String, apply: @escaping (Operand, Operand) -> Operand, precedence: NumericBinaryOperatorPrecedence,
         associativity: BinaryOperatorAssociativity, isCommutative: Bool)
    static var remainder: Self { get }
    static var bitwiseAND: Self { get }
    static var bitwiseOR: Self { get }
    static var bitwiseXOR: Self { get }
    static var bitwiseLeftShift: Self { get }
    static var bitwiseRightShift: Self { get }
}

extension BinaryIntegerBinaryOperatorProtocol {
    public static var remainder: Self { return Self.init(identifier: "%", apply: %, precedence: .multiplication, associativity: .left, isCommutative: false) }
    public static var bitwiseAND: Self { return Self.init(identifier: "&", apply: &, precedence: .multiplication, associativity: .left, isCommutative: true) }
    public static var bitwiseOR: Self { return Self.init(identifier: "|", apply: |, precedence: .addition, associativity: .left, isCommutative: true) }
    public static var bitwiseXOR: Self { return Self.init(identifier: "^", apply: ^, precedence: .addition, associativity: .left, isCommutative: true) }
    public static var bitwiseLeftShift: Self { return Self.init(identifier: "<<", apply: <<, precedence: .bitwiseShift, associativity: .none, isCommutative: false) }
    public static var bitwiseRightShift: Self { return Self.init(identifier: ">>", apply: >>, precedence: .bitwiseShift, associativity: .none, isCommutative: false) }
}
