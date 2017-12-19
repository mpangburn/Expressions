//
//  LogicalExpressionProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/18/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public protocol LogicalExpressionProtocol: EvaluatableExpressionProtocol, ExpressibleByBooleanLiteral where Node: LogicalBinaryOperatorProtocol {

    /// The type of the operators used in the expression.
    typealias Operator = Node
}

// MARK: - Default implementations

extension LogicalExpressionProtocol {
    public init(booleanLiteral boolean: Bool) {
        self = Self.makeExpression(operand: boolean)
    }
}

extension LogicalExpressionProtocol {
    public static func && (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, operator: .logicalAND, right: rhs)
    }

    public static func || (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, operator: .logicalOR, right: rhs)
    }
}

extension LogicalExpressionProtocol {
    public var shouldSpaceDescription: Bool { return true }
}
