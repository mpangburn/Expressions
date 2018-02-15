//
//  FloatingPointArithmeticExpression.swift
//  Expression
//
//  Created by Michael Pangburn on 12/17/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

// Once we have conditional conformance, FloatingPointArithmeticExpression need no longer exist!
/* extension ArithmeticExpression: ExpressibleByFloatLiteral where Operand: FloatingPoint & _ExpressibleByBuiltinFloatLiteral { } */

/// An arithmetic expression of floating point numbers modeled as a binary tree.
/// For integer operands, see ArithmeticExpression.
public enum FloatingPointArithmeticExpression<T: FloatingPoint & _ExpressibleByBuiltinFloatLiteral & _ExpressibleByBuiltinIntegerLiteral>: ArithmeticExpressionProtocol, ExpressibleByFloatLiteral {
    public typealias Operand = T
    public typealias UnaryOperator = NumericUnaryOperator<T>
    public typealias BinaryOperator = NumericBinaryOperator<T>

    case operand(Operand)
    indirect case unaryExpression(operator: UnaryOperator, operand: FloatingPointArithmeticExpression<T>)
    indirect case binaryExpression(left: FloatingPointArithmeticExpression<T>, operator: BinaryOperator, right: FloatingPointArithmeticExpression<T>)
}

// MARK: Required conformance to expression protocols

extension FloatingPointArithmeticExpression {
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

    public static func makeExpression(operand: Operand) -> FloatingPointArithmeticExpression<T> {
        return .operand(operand)
    }

    public static func makeExpression(unaryOperator: UnaryOperator, expression: FloatingPointArithmeticExpression<T>) -> FloatingPointArithmeticExpression<T> {
        return .unaryExpression(operator: unaryOperator, operand: expression)
    }

    public static func makeExpression(left: FloatingPointArithmeticExpression<T>, binaryOperator: BinaryOperator, right: FloatingPointArithmeticExpression<T>) -> FloatingPointArithmeticExpression<T> {
        return .binaryExpression(left: left, operator: binaryOperator, right: right)
    }
}

// MARK: - Required conformance to tree protocols

extension FloatingPointArithmeticExpression {
    public typealias Leaf = Operand
    public typealias Node = OperatorNodeKind<UnaryOperator, BinaryOperator>

    public var left: FloatingPointArithmeticExpression<T>? {
        switch self {
        case .operand:
            return nil
        case let .unaryExpression(_, operand):
            return operand
        case let .binaryExpression(left, _, _):
            return left
        }
    }

    public var right: FloatingPointArithmeticExpression<T>? {
        guard case let .binaryExpression(_, _, right) = self else { return nil }
        return right
    }
}
