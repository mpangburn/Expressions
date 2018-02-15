//
//  ArithmeticExpression.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

/// An arithmetic expression modeled as a binary tree.
/// For floating point operands, see FloatingPointArithmeticExpression.
public enum ArithmeticExpression<T: NumericOperandProtocol>: ArithmeticExpressionProtocol {
    public typealias Operand = T
    public typealias UnaryOperator = NumericUnaryOperator<T>
    public typealias BinaryOperator = NumericBinaryOperator<T>

    case operand(Operand)
    indirect case unaryExpression(operator: UnaryOperator, operand: ArithmeticExpression<T>)
    indirect case binaryExpression(left: ArithmeticExpression<T>, operator: BinaryOperator, right: ArithmeticExpression<T>)
}

// MARK: - Required conformance to expression protocols

extension ArithmeticExpression {
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

    public static func makeExpression(operand: Operand) -> ArithmeticExpression<T> {
        return .operand(operand)
    }

    public static func makeExpression(unaryOperator: UnaryOperator, expression: ArithmeticExpression<T>) -> ArithmeticExpression<T> {
        return .unaryExpression(operator: unaryOperator, operand: expression)
    }

    public static func makeExpression(left: ArithmeticExpression<T>, binaryOperator: BinaryOperator, right: ArithmeticExpression<T>) -> ArithmeticExpression<T> {
        return .binaryExpression(left: left, operator: binaryOperator, right: right)
    }
}

// MARK: - Required conformance to tree protocols

extension ArithmeticExpression {
    public typealias Leaf = Operand
    public typealias Node = OperatorNodeKind<UnaryOperator, BinaryOperator>

    public var left: ArithmeticExpression<T>? {
        switch self {
        case .operand:
            return nil
        case let .unaryExpression(_, operand):
            return operand
        case let .binaryExpression(left, _, _):
            return left
        }
    }

    public var right: ArithmeticExpression<T>? {
        guard case let .binaryExpression(_, _, right) = self else { return nil }
        return right
    }
}
