//
//  ArithmeticExpressionProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

/// A type representing an arithmetic expression.
public protocol ArithmeticExpressionProtocol: EvaluatableExpressionProtocol, Numeric where UnaryOperator: NumericUnaryOperatorProtocol, BinaryOperator: NumericBinaryOperatorProtocol { }

// MARK: - Default implementations

extension ArithmeticExpressionProtocol {
    public init(integerLiteral operand: Operand) {
        self = .makeExpression(operand: operand)
    }
}

extension ArithmeticExpressionProtocol where Self: ExpressibleByFloatLiteral {
    public init(floatLiteral operand: Operand) {
        self = .makeExpression(operand: operand)
    }
}

extension ArithmeticExpressionProtocol {
    public init?<T>(exactly source: T) where T: BinaryInteger {
        guard let operand = Operand(exactly: source) else { return nil }
        self = .makeExpression(operand: operand)
    }

    /// Evaluates the expression by applying its operators to its operands.
    /// - Returns: The value of the expression.
    public var magnitude: Operand {
        return evaluate()
    }
}

// MARK: - Operators

extension ArithmeticExpressionProtocol {
    public static prefix func + (expression: Self) -> Self {
        return makeExpression(unaryOperator: .unaryPlus, expression: expression)
    }

    public static func + (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, binaryOperator: .add, right: rhs)
    }

    public static func - (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, binaryOperator: .subtract, right: rhs)
    }

    public static func * (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, binaryOperator: .multiply, right: rhs)
    }
}

extension ArithmeticExpressionProtocol /*: Divisible */ where BinaryOperator.Operand: Divisible {
    public static func / (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, binaryOperator: .divide, right: rhs)
    }

    public static func /= (lhs: inout Self, rhs: Self) {
        lhs = lhs / rhs
    }
}

extension ArithmeticExpressionProtocol where UnaryOperator.Operand: SignedNumeric {
    public static prefix func - (expression: Self) -> Self {
        return makeExpression(unaryOperator: .unaryMinus, expression: expression)
    }
}

extension ArithmeticExpressionProtocol where UnaryOperator.Operand: BinaryInteger {
    public static prefix func ~ (expression: Self) -> Self {
        return makeExpression(unaryOperator: .bitwiseNOT, expression: expression)
    }
}

extension ArithmeticExpressionProtocol where BinaryOperator.Operand: BinaryInteger {
    public static func % (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, binaryOperator: .remainder, right: rhs)
    }

    public static func %= (lhs: inout Self, rhs: Self) {
        lhs = lhs % rhs
    }

    public static func & (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, binaryOperator: .bitwiseAND, right: rhs)
    }

    public static func &= (lhs: inout Self, rhs: Self) {
        lhs = lhs & rhs
    }

    public static func | (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, binaryOperator: .bitwiseOR, right: rhs)
    }

    public static func |= (lhs: inout Self, rhs: Self) {
        lhs = lhs | rhs
    }

    public static func ^ (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, binaryOperator: .bitwiseXOR, right: rhs)
    }

    public static func ^= (lhs: inout Self, rhs: Self) {
        lhs = lhs ^ rhs
    }

    public static func << (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, binaryOperator: .bitwiseLeftShift, right: rhs)
    }

    public static func <<= (lhs: inout Self, rhs: Self) {
        lhs = lhs << rhs
    }

    public static func >> (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, binaryOperator: .bitwiseRightShift, right: rhs)
    }

    public static func >>= (lhs: inout Self, rhs: Self) {
        lhs = lhs >> rhs
    }
}

extension ArithmeticExpressionProtocol where BinaryOperator.Operand: FixedWidthInteger {
    public static func &+ (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, binaryOperator: .addIgnoringOverflow, right: rhs)
    }

    public static func &- (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, binaryOperator: .subtractIgnoringOverflow, right: rhs)
    }

    public static func &* (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, binaryOperator: .multiplyIgnoringOverflow, right: rhs)
    }

    public static func &<< (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, binaryOperator: .bitwiseLeftMaskingShift, right: rhs)
    }

    public static func &>> (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, binaryOperator: .bitwiseRightMaskingShift, right: rhs)
    }
}
