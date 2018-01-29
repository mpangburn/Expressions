//
//  BinaryOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

/// An operator that performs an operation on exactly two operands.
public protocol BinaryOperatorProtocol: OperatorProtocol {
    init(identifier: String, apply: @escaping (Operand, Operand) -> Result, precedence: BinaryOperatorPrecedence,
         associativity: BinaryOperatorAssociativity, isCommutative: Bool)

    /// The function to apply to two operands to produce the result.
    var apply: (Operand, Operand) -> Result { get }

    /// The operator's precedence, which is used to determine the order of operations when combined with other operators.
    var precedence: BinaryOperatorPrecedence { get }

    /// A property that determines how operators of the same precedence are grouped in the absence of parentheses.
    var associativity: BinaryOperatorAssociativity { get }

    /// A boolean value representing whether the operator is commutative,
    /// i.e. whether the order of the operands affects the result of the operation.
    var isCommutative: Bool { get }
}
