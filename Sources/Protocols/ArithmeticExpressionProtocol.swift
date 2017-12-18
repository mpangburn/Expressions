//
//  ArithmeticExpressionProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A type representing an arithmetic expression.
public protocol ArithmeticExpressionProtocol: CustomPlaygroundQuickLookableBinaryTreeProtocol, NeverEmptyTreeProtocol, Evaluatable, Numeric, CustomStringConvertible where Node: NumericBinaryOperatorProtocol, Leaf == Node.Operand, Result == Leaf {

    /// The type of the operands used in the expression.
    typealias Operand = Leaf

    /// The type of the operators used in the expression.
    typealias Operator = Node

    /// Returns an expression consisting of the single operand.
    /// - Parameter operand: The operand used to create the expression.
    /// - Returns: An expression consisting of the single operand.
    static func makeExpression(operand: Operand) -> Self

    /// Returns an expression consisting of the left expression and the right expression combined by the operator.
    /// - Parameters:
    ///     - left: The left side of the expression.
    ///     - operator: The operator combining the two sides of the expression.
    ///     - right: The right side of the expression.
    /// - Returns: An expression consisting of the left expression and the right expression combined by the operator.
    static func makeExpression(left: Self, operator: Operator, right: Self) -> Self
}

extension ArithmeticExpressionProtocol {
    public init?<T>(exactly source: T) where T: BinaryInteger {
        guard let operand = Operand(exactly: source) else { return nil }
        self = Self.makeExpression(operand: operand)
    }

    /// Evaluates the expression by applying the operators to their operands.
    /// - Returns: The value of the expression.
    public var magnitude: Operand {
        switch safeKind {
        case let .leaf(operand):
            return operand
        case let .node(`operator`):
            guard let left = left, let right = right else { fatalError("A binary operator must have two operands.") }
            return `operator`.apply(left.evaluate(), right.evaluate())
        }
    }

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
    public init(integerLiteral operand: Operand) {
        self = Self.makeExpression(operand: operand)
    }
}

extension ArithmeticExpressionProtocol where Self: ExpressibleByFloatLiteral {
    public init(floatLiteral operand: Operand) {
        self = Self.makeExpression(operand: operand)
    }
}

extension ArithmeticExpressionProtocol {

    /// Tests the expressions for effective equality.
    /// To test equality of underlying tree structures, use the instance method `deepEquals(_:)`.
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.description == rhs.description
    }

    /// Tests the underlying tree structures of the two expressions for equality.
    /// - Parameter other: The expression with which to test for equality.
    /// - Returns: A boolean value representing whether the two expressions are deeply equal.
    public func deepEquals(_ other: Self) -> Bool {
        return safeKind == other.safeKind && children == other.children
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
