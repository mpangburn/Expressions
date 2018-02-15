//
//  LogicalExpression.swift
//  Expression
//
//  Created by Michael Pangburn on 12/18/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

/// An expression of boolean logic.
//public typealias LogicalExpression = LogicalExpression<LogicalUnaryOperator, LogicalBinaryOperator>

/// An expression of boolean logic modeled as a binary tree.
/// Use the typealias LogicalExpression rather than working with this type directly.
public enum LogicalExpression: LogicalExpressionProtocol {
    public typealias Operand = Bool
    public typealias UnaryOperator = LogicalUnaryOperator
    public typealias BinaryOperator = LogicalBinaryOperator

    case operand(Operand)
    indirect case unaryExpression(operator: UnaryOperator, operand: LogicalExpression)
    indirect case binaryExpression(left: LogicalExpression, operator: BinaryOperator, right: LogicalExpression)
}

// MARK: - Required conformance to expression protocols

extension LogicalExpression {
    public var expressionNodeKind: ExpressionNodeKind<UnaryOperator, BinaryOperator> {
        switch self {
        case let .operand(operand):
            return .operand(operand)
        case let .unaryExpression(`operator`, _):
            return .unaryOperator(`operator`)
        case let .binaryExpression(_, `operator`, _):
            return .binaryOperator(`operator`)
        }
    }

    public static func makeExpression(operand: Operand) -> LogicalExpression {
        return .operand(operand)
    }

    public static func makeExpression(unaryOperator: UnaryOperator, expression: LogicalExpression) -> LogicalExpression {
        return .unaryExpression(operator: unaryOperator, operand: expression)
    }

    public static func makeExpression(left: LogicalExpression, binaryOperator: BinaryOperator, right: LogicalExpression) -> LogicalExpression {
        return .binaryExpression(left: left, operator: binaryOperator, right: right)
    }
}

// MARK: - Required conformance to tree protocols

extension LogicalExpression {
    public typealias Leaf = Operand
    public typealias Node = OperatorNodeKind<UnaryOperator, BinaryOperator>

    public var left: LogicalExpression? {
        switch self {
        case .operand:
            return nil
        case let .unaryExpression(_, operand):
            return operand
        case let .binaryExpression(left, _, _):
            return left
        }
    }

    public var right: LogicalExpression? {
        guard case let .binaryExpression(_, _, right) = self else { return nil }
        return right
    }
}
