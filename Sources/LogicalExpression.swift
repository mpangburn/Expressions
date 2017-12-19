//
//  LogicalExpression.swift
//  Expression
//
//  Created by Michael Pangburn on 12/18/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public enum LogicalExpression: LogicalExpressionProtocol {
    public typealias Operand = Bool
    public typealias Operator = LogicalBinaryOperator

    case operand(Operand)
    indirect case expression(left: LogicalExpression, operator: Operator, right: LogicalExpression)
}

// MARK: - Required conformance to tree protocols

extension LogicalExpression {
    public var kind: Either<Operand, Operator>? {
        switch self {
        case let .operand(operand):
            return .leaf(operand)
        case let .expression(_, `operator`, _):
            return .node(`operator`)
        }
    }

    public var left: LogicalExpression? {
        guard case let .expression(left, _, _) = self else { return nil }
        return left
    }

    public var right: LogicalExpression? {
        guard case let .expression(_, _, right) = self else { return nil }
        return right
    }

    public static func makeExpression(operand: Operand) -> LogicalExpression {
        return .operand(operand)
    }

    public static func makeExpression(left: LogicalExpression, operator: Operator, right: LogicalExpression) -> LogicalExpression {
        return .expression(left: left, operator: `operator`, right: right)
    }
}
