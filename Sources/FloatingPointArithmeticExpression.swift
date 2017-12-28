//
//  FloatingPointArithmeticExpression.swift
//  Expression
//
//  Created by Michael Pangburn on 12/17/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import UIKit


/// An arithmetic expression whose operands are of a floating point type.
public typealias FloatingPointArithmeticExpression<T: FloatingPointOperandProtocol> = _FloatingPointArithmeticExpression<NumericUnaryOperator<T>, FloatingPointBinaryOperator<T>>

// Once we have conditional conformance, FloatingPointArithmeticExpression can become restricted typealias for _ArithmeticExpression.
/* extension _ArithmeticExpression: ExpressibleByFloatLiteral where Operand: FloatingPointOperandProtocol { } */

/// An arithmetic expression of floating point numbers modeled as a binary tree.
/// Use the typealias FloatingPointArithmeticExpression rather than working with this type directly.
/// For integer operands, see ArithmeticExpression.
public enum _FloatingPointArithmeticExpression<UnaryOperator: NumericUnaryOperatorProtocol, BinaryOperator: FloatingPointBinaryOperatorProtocol>: ArithmeticExpressionProtocol, ExpressibleByFloatLiteral where UnaryOperator.Operand == BinaryOperator.Operand {

    public typealias Operand = UnaryOperator.Operand

    case operand(Operand)
    indirect case unaryExpression(operator: UnaryOperator, operand: _FloatingPointArithmeticExpression<UnaryOperator, BinaryOperator>)
    indirect case binaryExpression(left: _FloatingPointArithmeticExpression<UnaryOperator, BinaryOperator>, operator: BinaryOperator, right: _FloatingPointArithmeticExpression<UnaryOperator, BinaryOperator>)
}

// MARK: - Required conformance to tree protocols

extension _FloatingPointArithmeticExpression {
    public typealias Leaf = Operand
    public typealias Node = OperatorNodeKind<UnaryOperator, BinaryOperator>

    public var left: _FloatingPointArithmeticExpression<UnaryOperator, BinaryOperator>? {
        switch self {
        case .operand:
            return nil
        case let .unaryExpression(_, operand):
            return operand
        case let .binaryExpression(left, _, _):
            return left
        }
    }

    public var right: _FloatingPointArithmeticExpression<UnaryOperator, BinaryOperator>? {
        guard case let .binaryExpression(_, _, right) = self else { return nil }
        return right
    }
}

// MARK: Required conformance to expression protocols

extension _FloatingPointArithmeticExpression {
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

    public static func makeExpression(operand: Operand) -> _FloatingPointArithmeticExpression<UnaryOperator, BinaryOperator> {
        return .operand(operand)
    }

    public static func makeExpression(unaryOperator: UnaryOperator, operand: _FloatingPointArithmeticExpression<UnaryOperator, BinaryOperator>) -> _FloatingPointArithmeticExpression<UnaryOperator, BinaryOperator> {
        return .unaryExpression(operator: unaryOperator, operand: operand)
    }

    public static func makeExpression(left: _FloatingPointArithmeticExpression<UnaryOperator, BinaryOperator>, binaryOperator: BinaryOperator, right: _FloatingPointArithmeticExpression<UnaryOperator, BinaryOperator>) -> _FloatingPointArithmeticExpression<UnaryOperator, BinaryOperator> {
        return .binaryExpression(left: left, operator: binaryOperator, right: right)
    }
}

// MARK: - Visual attributes

extension _FloatingPointArithmeticExpression {
    public var visualAttributes: NodeVisualAttributes? {
        let size = CGSize(width: 32, height: 32)
        let color: UIColor
        let text: String
        let textAttributes = NodeVisualAttributes.Default.textAttributes

        switch neverEmptyNodeKind {
        case let .leaf(value):
            color = .flatBlue
            let displayValue = (value * 10).rounded() / 10
            text = String(describing: displayValue)
        case let .node(value):
            color = .flatRed
            text = String(describing: value)
        }

        let connectingLineColor = color

        return NodeVisualAttributes(size: size, color: color, text: text, textAttributes: textAttributes, connectingLineColor: connectingLineColor)
    }
}
