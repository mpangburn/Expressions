//
//  ArithmeticExpression.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// An arithmetic expression whose operands are of an integer type.
public typealias ArithmeticExpression<T: FixedWidthIntegerOperandProtocol> = _ArithmeticExpression<BinaryIntegerUnaryOperator<T>, FixedWidthIntegerBinaryOperator<T>>

/// An arithmetic expression modeled as a binary tree.
/// Use the typealias ArithmeticExpression rather than working with this type directly.
/// For floating point operands, see FloatingPointExpression.
public enum _ArithmeticExpression<UnaryOperator: NumericUnaryOperatorProtocol, BinaryOperator: NumericBinaryOperatorProtocol>: ArithmeticExpressionProtocol where UnaryOperator.Operand == BinaryOperator.Operand {
    public typealias Operand = UnaryOperator.Operand

    case operand(Operand)
    indirect case unaryExpression(operator: UnaryOperator, operand: _ArithmeticExpression<UnaryOperator, BinaryOperator>)
    indirect case binaryExpression(left: _ArithmeticExpression<UnaryOperator, BinaryOperator>, operator: BinaryOperator, right: _ArithmeticExpression<UnaryOperator, BinaryOperator>)
}

// MARK: - Required conformance to tree protocols

extension _ArithmeticExpression {
    public typealias Leaf = Operand
    public typealias Node = OperatorNodeKind<UnaryOperator, BinaryOperator>

    public var left: _ArithmeticExpression<UnaryOperator, BinaryOperator>? {
        switch self {
        case .operand:
            return nil
        case let .unaryExpression(_, operand):
            return operand
        case let .binaryExpression(left, _, _):
            return left
        }
    }

    public var right: _ArithmeticExpression<UnaryOperator, BinaryOperator>? {
        guard case let .binaryExpression(_, _, right) = self else { return nil }
        return right
    }
}

// MARK: - Required conformance to expression protocols

extension _ArithmeticExpression {
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

    public static func makeExpression(operand: Operand) -> _ArithmeticExpression<UnaryOperator, BinaryOperator> {
        return .operand(operand)
    }

    public static func makeExpression(unaryOperator: UnaryOperator, operand: _ArithmeticExpression<UnaryOperator, BinaryOperator>) -> _ArithmeticExpression<UnaryOperator, BinaryOperator> {
        return .unaryExpression(operator: unaryOperator, operand: operand)
    }

    public static func makeExpression(left: _ArithmeticExpression<UnaryOperator, BinaryOperator>, binaryOperator: BinaryOperator, right: _ArithmeticExpression<UnaryOperator, BinaryOperator>) -> _ArithmeticExpression<UnaryOperator, BinaryOperator> {
        return .binaryExpression(left: left, operator: binaryOperator, right: right)
    }
}
