//
//  ArithmeticExpressionProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public protocol ArithmeticExpressionProtocol: CustomPlaygroundQuickLookableBinaryTreeProtocol, NeverEmptyTreeProtocol, Evaluatable, Numeric, CustomStringConvertible where Node: NumericBinaryOperatorProtocol, Leaf == Node.Operand {
    typealias Operand = Leaf
    typealias Operator = Node
    static func makeOperand(_ operand: Operand) -> Self
    static func makeExpression(left: Self, operator: Operator, right: Self) -> Self
}

extension ArithmeticExpressionProtocol {
    public func evaluate() -> Operand {
        switch safeKind {
        case let .leaf(operand):
            return operand
        case let .node(`operator`):
            guard let left = left, let right = right else { fatalError("A binary operator must have two operands.") }
            return `operator`.apply(left.evaluate(), right.evaluate())
        }
    }
}

extension ArithmeticExpressionProtocol {
    public init(integerLiteral operand: Operand) {
        self = Self.makeOperand(operand)
    }
}

extension ArithmeticExpressionProtocol where Self: ExpressibleByFloatLiteral {
    public init(floatLiteral operand: Operand) {
        self = Self.makeOperand(operand)
    }
}

extension ArithmeticExpressionProtocol {
    public init?<T>(exactly source: T) where T: BinaryInteger {
        guard let operand = Operand(exactly: source) else { return nil }
        self = Self.makeOperand(operand)
    }

    public var magnitude: Operand {
        return evaluate()
    }
}

extension ArithmeticExpressionProtocol {

    /// Compares the expressions for effective equality.
    /// To test equality of underlying tree structures, use the instance method `deepEquals(_:)`.
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.description == rhs.description
    }

    public func deepEquals(_ other: Self) -> Bool {
        return safeKind == other.safeKind && children == other.children
    }
}

extension ArithmeticExpressionProtocol {
    public static func + (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, operator: .add, right: rhs)
    }

    public static func - (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, operator: .subtract, right: rhs)
    }

    public static func * (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, operator: .multiply, right: rhs)
    }
}

extension ArithmeticExpressionProtocol where Node: DivisibleBinaryOperatorProtocol {
    public static func / (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, operator: .divide, right: rhs)
    }
}

extension ArithmeticExpressionProtocol where Node: BinaryIntegerBinaryOperatorProtocol {
    public static func % (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, operator: .remainder, right: rhs)
    }

    public static func & (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, operator: .bitwiseAND, right: rhs)
    }

    public static func | (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, operator: .bitwiseOR, right: rhs)
    }

    public static func ^ (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, operator: .bitwiseXOR, right: rhs)
    }

    public static func << (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, operator: .bitwiseLeftShift, right: rhs)
    }

    public static func >> (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, operator: .bitwiseRightShift, right: rhs)
    }
}

extension ArithmeticExpressionProtocol where Node: FixedWidthIntegerBinaryOperatorProtocol {
    public static func &+ (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, operator: .addIgnoringOverflow, right: rhs)
    }

    public static func &- (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, operator: .subtractIgnoringOverflow, right: rhs)
    }

    public static func &* (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, operator: .multiplyIgnoringOverflow, right: rhs)
    }

    public static func &<< (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, operator: .bitwiseLeftMaskingShift, right: rhs)
    }

    public static func &>> (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, operator: .bitwiseRightMaskingShift, right: rhs)
    }
}

extension ArithmeticExpressionProtocol {
    public var description: String {
        switch safeKind {
        case let .leaf(operand):
            return String(describing: operand)
        case let .node(`operator`):
            guard let left = left, let right = right else { fatalError("A binary operator must have two operands.") }
            let leftString: String
            if case let .node(leftOperator) = left.safeKind, leftOperator.precedence < `operator`.precedence {
                leftString = "(\(left.description))"
            } else {
                leftString = left.description
            }

            let rightString: String
            if case let .node(rightOperator) = right.safeKind, rightOperator.precedence < `operator`.precedence {
                rightString = "(\(right.description))"
            } else {
                rightString = right.description
            }

            return "\(leftString)\(`operator`)\(rightString)"
        }
    }
}
