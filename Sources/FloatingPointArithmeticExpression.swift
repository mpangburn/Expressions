//
//  FloatingPointArithmeticExpression.swift
//  Expression
//
//  Created by Michael Pangburn on 12/17/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// An arithmetic expression whose operands are of a floating point type.
public typealias FloatingPointArithmeticExpression<T: FloatingPointOperandProtocol> = _FloatingPointArithmeticExpression<FloatingPointBinaryOperator<T>>

/// An arithmetic expression of floating point numbers modeled as a binary tree.
/// Use the typealias FloatingPointArithmeticExpression rather than working with this type directly.
/// For integer operands, see ArithmeticExpression.
public enum _FloatingPointArithmeticExpression<Operator: FloatingPointBinaryOperatorProtocol>: ArithmeticExpressionProtocol, ExpressibleByFloatLiteral {
    public typealias Operand = Operator.Operand

    case operand(Operand)
    indirect case expression(left: _FloatingPointArithmeticExpression<Operator>, operator: Operator, right: _FloatingPointArithmeticExpression<Operator>)
}

// MARK: - Required conformance to tree protocols

extension _FloatingPointArithmeticExpression {
    public var kind: TreeNode<Operand, Operator>? {
        switch self {
        case let .operand(operand):
            return .leaf(operand)
        case let .expression(_, `operator`, _):
            return .node(`operator`)
        }
    }

    public var left: _FloatingPointArithmeticExpression<Operator>? {
        guard case let .expression(left, _, _) = self else { return nil }
        return left
    }

    public var right: _FloatingPointArithmeticExpression<Operator>? {
        guard case let .expression(_, _, right) = self else { return nil }
        return right
    }
}

// MARK: Required conformance to expression protocols

extension _FloatingPointArithmeticExpression {
    public static func makeExpression(operand: Operand) -> _FloatingPointArithmeticExpression<Operator> {
        return .operand(operand)
    }

    public static func makeExpression(left: _FloatingPointArithmeticExpression<Operator>, operator: Operator, right: _FloatingPointArithmeticExpression<Operator>) -> _FloatingPointArithmeticExpression<Operator> {
        return .expression(left: left, operator: `operator`, right: right)
    }
}
