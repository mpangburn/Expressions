//
//  ArithmeticExpressionProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A type representing an arithmetic expression.
public protocol ArithmeticExpressionProtocol: EvaluatableExpressionProtocol, Numeric where Node: NumericBinaryOperatorProtocol { }

// MARK: - Default implementations

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
    public init?<T>(exactly source: T) where T: BinaryInteger {
        guard let operand = Operand(exactly: source) else { return nil }
        self = Self.makeExpression(operand: operand)
    }

    /// Evaluates the expression by applying the operators to their operands.
    /// - Returns: The value of the expression.
    public var magnitude: Operand {
        return evaluate()
    }
}

// MARK: - Operators

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

extension ArithmeticExpressionProtocol /*: Divisible */ where Node: DivisibleBinaryOperatorProtocol {
    public static func / (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, operator: .divide, right: rhs)
    }

    public static func /= (lhs: inout Self, rhs: Self) {
        lhs = lhs / rhs
    }
}

extension ArithmeticExpressionProtocol where Node: BinaryIntegerBinaryOperatorProtocol {
    public static func % (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, operator: .remainder, right: rhs)
    }

    public static func %= (lhs: inout Self, rhs: Self) {
        lhs = lhs % rhs
    }

    public static func & (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, operator: .bitwiseAND, right: rhs)
    }

    public static func &= (lhs: inout Self, rhs: Self) {
        lhs = lhs & rhs
    }

    public static func | (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, operator: .bitwiseOR, right: rhs)
    }

    public static func |= (lhs: inout Self, rhs: Self) {
        lhs = lhs | rhs
    }

    public static func ^ (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, operator: .bitwiseXOR, right: rhs)
    }

    public static func ^= (lhs: inout Self, rhs: Self) {
        lhs = lhs ^ rhs
    }

    public static func << (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, operator: .bitwiseLeftShift, right: rhs)
    }

    public static func <<= (lhs: inout Self, rhs: Self) {
        lhs = lhs << rhs
    }

    public static func >> (lhs: Self, rhs: Self) -> Self {
        return makeExpression(left: lhs, operator: .bitwiseRightShift, right: rhs)
    }

    public static func >>= (lhs: inout Self, rhs: Self) {
        lhs = lhs >> rhs
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
