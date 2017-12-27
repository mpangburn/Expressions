//
//  LogicalExpression.swift
//  Expression
//
//  Created by Michael Pangburn on 12/18/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// An expression of boolean logic.
public typealias LogicalExpression = _LogicalExpression<LogicalBinaryOperator>

/// An expression of boolean logic modeled as a binary tree.
/// Use the typealias LogicalExpression rather than working with this type directly.
public enum _LogicalExpression<Operator: LogicalBinaryOperatorProtocol>: LogicalExpressionProtocol {
    public typealias Operand = Bool

    case operand(Operand)
    indirect case expression(left: _LogicalExpression, operator: Operator, right: _LogicalExpression)
}

// MARK: - Required conformance to tree protocols

extension _LogicalExpression {
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

    public var left: _LogicalExpression<Operator>? {
        guard case let .expression(left, _, _) = self else { return nil }
        return left
    }

    public var right: _LogicalExpression<Operator>? {
        guard case let .expression(_, _, right) = self else { return nil }
        return right
    }
}

// MARK: - Required conformance to expression protocols

extension _LogicalExpression {
    public static func makeExpression(operand: Operand) -> _LogicalExpression<Operator> {
        return .operand(operand)
    }

    public static func makeExpression(left: _LogicalExpression<Operator>, operator: Operator, right: _LogicalExpression<Operator>) -> _LogicalExpression<Operator> {
        return .expression(left: left, operator: `operator`, right: right)
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
