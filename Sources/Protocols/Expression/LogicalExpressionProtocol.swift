//
//  LogicalExpressionProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/18/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A type representing a logical expression.
public protocol LogicalExpressionProtocol: EvaluatableExpressionProtocol, ExpressibleByBooleanLiteral where UnaryOperator: LogicalUnaryOperatorProtocol, BinaryOperator: LogicalBinaryOperatorProtocol { }

// MARK: - Default implementations

extension LogicalExpressionProtocol {
    public init(booleanLiteral boolean: Bool) {
        self = .makeExpression(operand: boolean)
    }
}

extension LogicalExpressionProtocol {
    public var shouldSpaceDescription: Bool {
        return true
    }
}

// MARK: - Operators

extension LogicalExpressionProtocol {
    public static prefix func ! (expression: Self) -> Self {
        return makeExpression(unaryOperator: .logicalNOT, operand: expression)
    }

    public static func && (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, binaryOperator: .logicalAND, right: rhs)
    }

    public static func || (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, binaryOperator: .logicalOR, right: rhs)
    }
}
