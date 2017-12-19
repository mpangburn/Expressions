//
//  LogicalBinaryOperator.swift
//  Expression
//
//  Created by Michael Pangburn on 12/18/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public struct LogicalBinaryOperator: LogicalBinaryOperatorProtocol {
    public typealias Operand = Bool
    public typealias Result = Bool

    public let identifier: String
    public let apply: (Operand, Operand) -> Result
    public let precedence: BinaryOperatorPrecedence
    public let associativity: BinaryOperatorAssociativity
    public let isCommutative: Bool

    public init(identifier: String, apply: @escaping (Operand, Operand) -> Result, precedence: BinaryOperatorPrecedence, associativity: BinaryOperatorAssociativity, isCommutative: Bool) {
        self.identifier = identifier
        self.apply = apply
        self.precedence = precedence
        self.associativity = associativity
        self.isCommutative = isCommutative
    }
}
