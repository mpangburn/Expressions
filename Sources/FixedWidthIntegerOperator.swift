//
//  FixedWidthIntegerOperator.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public struct FixedWidthIntegerOperator<T: FixedWidthIntegerOperandProtocol>: FixedWidthIntegerBinaryOperatorProtocol {
    public typealias Operand = T
    public typealias Result = T

    public var identifier: String
    public var apply: (Operand, Operand) -> Operand
    public var precedence: NumericBinaryOperatorPrecedence
    public var associativity: BinaryOperatorAssociativity
    public var isCommutative: Bool

    public init(identifier: String, apply: @escaping (Operand, Operand) -> Operand, precedence: NumericBinaryOperatorPrecedence, associativity: BinaryOperatorAssociativity, isCommutative: Bool) {
        self.identifier = identifier
        self.apply = apply
        self.precedence = precedence
        self.associativity = associativity
        self.isCommutative = isCommutative
    }
}
