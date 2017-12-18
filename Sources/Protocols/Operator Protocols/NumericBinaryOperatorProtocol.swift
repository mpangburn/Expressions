//
//  NumericBinaryOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public protocol NumericBinaryOperatorProtocol: BinaryOperatorProtocol where Operand: Numeric & Comparable & _ExpressibleByBuiltinIntegerLiteral, Result == Operand, Precedence == NumericBinaryOperatorPrecedence {
    init(identifier: String, apply: @escaping (Operand, Operand) -> Operand, precedence: NumericBinaryOperatorPrecedence,
         associativity: BinaryOperatorAssociativity, isCommutative: Bool)
    static var add: Self { get }
    static var subtract: Self { get }
    static var multiply: Self { get }
}

extension NumericBinaryOperatorProtocol {
    public static var add: Self { return Self.init(identifier: "+", apply: +, precedence: .addition, associativity: .left, isCommutative: true) }
    public static var subtract: Self { return Self.init(identifier: "-", apply: -, precedence: .addition, associativity: .left, isCommutative: false) }
    public static var multiply: Self { return Self.init(identifier: "*", apply: *, precedence: .multiplication, associativity: .left, isCommutative: true) }
}
