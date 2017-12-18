//
//  FloatingPointArithmeticExpression.swift
//  Expression
//
//  Created by Michael Pangburn on 12/17/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public typealias FloatingPointArithmeticExpression<T: FloatingPointOperandProtocol> = _FloatingPointArithmeticExpression<FloatingPointBinaryOperator<T>>

public enum _FloatingPointArithmeticExpression<Operator: FloatingPointBinaryOperatorProtocol>: ArithmeticExpressionProtocol, ExpressibleByFloatLiteral {
    public typealias Operand = Operator.Operand

    case operand(Operand)
    indirect case expression(left: _FloatingPointArithmeticExpression<Operator>, operator: Operator, right: _FloatingPointArithmeticExpression<Operator>)
}

// MARK: - Boilerplate conformance
extension _FloatingPointArithmeticExpression {
    public var kind: Either<Operand, Operator> {
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

    public static func makeOperand(_ operand: Operand) -> _FloatingPointArithmeticExpression<Operator> {
        return .operand(operand)
    }

    public static func makeExpression(left: _FloatingPointArithmeticExpression<Operator>, operator: Operator, right: _FloatingPointArithmeticExpression<Operator>) -> _FloatingPointArithmeticExpression<Operator> {
        return .expression(left: left, operator: `operator`, right: right)
    }
}
