//
//  NumericUnaryOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/28/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

/// A unary operator for performing operations on Numeric types.
public protocol NumericUnaryOperatorProtocol: UnaryOperatorProtocol where Operand: Numeric, Result == Operand { }

// MARK: - Operators

extension NumericUnaryOperatorProtocol {
    public static var unaryPlus: Self { return .init(identifier: "+", apply: +) }
}

extension NumericUnaryOperatorProtocol where Operand: SignedNumeric {
    public static var unaryMinus: Self { return .init(identifier: "-", apply: -) }
}

extension NumericUnaryOperatorProtocol where Operand: BinaryInteger {
    public static var bitwiseNOT: Self { return .init(identifier: "~", apply: ~) }
}
