//
//  LogicalExpression.swift
//  Expression
//
//  Created by Michael Pangburn on 12/18/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// An expression of boolean logic.
public typealias LogicalExpression = _LogicalExpression<LogicalUnaryOperator, LogicalBinaryOperator>

/// An expression of boolean logic modeled as a binary tree.
/// Use the typealias LogicalExpression rather than working with this type directly.
public enum _LogicalExpression<UnaryOperator: LogicalUnaryOperatorProtocol, BinaryOperator: LogicalBinaryOperatorProtocol>: LogicalExpressionProtocol {
    public typealias Operand = Bool

    case operand(Operand)
    indirect case unaryExpression(operator: UnaryOperator, operand: _LogicalExpression)
    indirect case binaryExpression(left: _LogicalExpression, operator: BinaryOperator, right: _LogicalExpression)
}

// MARK: - Required conformance to tree protocols

extension _LogicalExpression {
    public typealias Leaf = Operand
    public typealias Node = OperatorNodeKind<UnaryOperator, BinaryOperator>

    public var left: _LogicalExpression<UnaryOperator, BinaryOperator>? {
        switch self {
        case .operand:
            return nil
        case let .unaryExpression(_, operand):
            return operand
        case let .binaryExpression(left, _, _):
            return left
        }
    }

    public var right: _LogicalExpression<UnaryOperator, BinaryOperator>? {
        guard case let .binaryExpression(_, _, right) = self else { return nil }
        return right
    }
}

// MARK: - Required conformance to expression protocols

extension _LogicalExpression {
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

    public static func makeExpression(operand: Operand) -> _LogicalExpression<UnaryOperator, BinaryOperator> {
        return .operand(operand)
    }

    public static func makeExpression(unaryOperator: UnaryOperator, operand: _LogicalExpression<UnaryOperator, BinaryOperator>) -> _LogicalExpression<UnaryOperator, BinaryOperator> {
        return .unaryExpression(operator: unaryOperator, operand: operand)
    }

    public static func makeExpression(left: _LogicalExpression<UnaryOperator, BinaryOperator>, binaryOperator: BinaryOperator, right: _LogicalExpression<UnaryOperator, BinaryOperator>) -> _LogicalExpression<UnaryOperator, BinaryOperator> {
        return .binaryExpression(left: left, operator: binaryOperator, right: right)
    }
}

// MARK: - Visual attributes

extension _LogicalExpression {
    public var visualAttributes: NodeVisualAttributes? {
        let size = CGSize(width: 36, height: 36)
        let color: UIColor
        let text: String
        let textAttributes = NodeVisualAttributes.Default.textAttributes

        switch neverEmptyNodeKind {
        case let .leaf(value):
            color = value ? .flatGreen2 : .flatRed2
            text = String(describing: value)
        case let .node(value):
            color = .flatBlue2
            text = String(describing: value)
        }

        let connectingLineColor = color

        return NodeVisualAttributes(size: size, color: color, text: text, textAttributes: textAttributes, connectingLineColor: connectingLineColor)
    }
}
