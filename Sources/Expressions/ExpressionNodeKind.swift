//
//  ExpressionNodeKind.swift
//  Expression
//
//  Created by Michael Pangburn on 12/26/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

/// The kind of an expression node--either an operand, a unary operator, or a binary operator.
public enum ExpressionNodeKind<UnaryOperator: UnaryOperatorProtocol, BinaryOperator: BinaryOperatorProtocol> where UnaryOperator.Operand == BinaryOperator.Operand {
    public typealias Operand = UnaryOperator.Operand

    case operand(Operand)
    case unaryOperator(UnaryOperator)
    case binaryOperator(BinaryOperator)
}
