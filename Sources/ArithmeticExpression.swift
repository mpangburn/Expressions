//
//  ArithmeticExpression.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// An arithmetic expression whose operands are of an integer type.
public typealias ArithmeticExpression<T: FixedWidthIntegerOperandProtocol> = _ArithmeticExpression<FixedWidthIntegerBinaryOperator<T>>

/// An arithmetic expression modeled as a binary tree.
/// Use the typealias ArithmeticExpression rather than working with this type directly.
/// For floating point operands, see FloatingPointExpression.
public enum _ArithmeticExpression<Operator: NumericBinaryOperatorProtocol>: ArithmeticExpressionProtocol {
    public typealias Operand = Operator.Operand

    case operand(Operand)
    indirect case expression(left: _ArithmeticExpression<Operator>, operator: Operator, right: _ArithmeticExpression<Operator>)
}

// Once we have conditional conformance, FloatingPointArithmeticExpression can become restricted typealias for _ArithmeticExpression.
/* extension _ArithmeticExpression: ExpressibleByFloatingPointLiteral where Operand: FloatingPointOperandProtocol { } */

// MARK: - Required conformance to tree protocols

extension _ArithmeticExpression {
    public typealias Leaf = Operand
    public typealias Node = Operator

    public var neverEmptyNodeKind: NeverEmptyTreeNode<Operand, Operator> {
        switch self {
        case let .operand(operand):
            return .leaf(operand)
        case let .expression(_, `operator`, _):
            return .node(`operator`)
        }
    }

    public var left: _ArithmeticExpression<Operator>? {
        guard case let .expression(left, _, _) = self else { return nil }
        return left
    }

    public var right: _ArithmeticExpression<Operator>? {
        guard case let .expression(_, _, right) = self else { return nil }
        return right
    }
}

// MARK: - Required conformance to expression protocols

extension _ArithmeticExpression {
    public static func makeExpression(operand: Operand) -> _ArithmeticExpression<Operator> {
        return .operand(operand)
    }

    public static func makeExpression(left: _ArithmeticExpression<Operator>, operator: Operator, right: _ArithmeticExpression<Operator>) -> _ArithmeticExpression<Operator> {
        return .expression(left: left, operator: `operator`, right: right)
    }
}
