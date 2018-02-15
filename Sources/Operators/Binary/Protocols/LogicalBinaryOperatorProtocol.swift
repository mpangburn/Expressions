//
//  LogicalBinaryOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/18/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//


/// A binary operator that applies boolean logic.
public protocol LogicalBinaryOperatorProtocol: BinaryOperatorProtocol where Operand == Bool, Result == Bool { }

// MARK: - Operators

extension LogicalBinaryOperatorProtocol {
    // Since the type of && and || as operators in Swift is actually `(Bool, @autoclosure () throws -> Bool) throws -> Bool`
    // (for short-circuiting purposes), we must wrap these operators in closures.
    public static var logicalAND: Self { return .init(identifier: "&&", apply: { $0 && $1 }, precedence: .logicalConjunction, associativity: .left, isCommutative: true) }
    public static var logicalOR: Self { return .init(identifier: "||", apply: { $0 || $1 }, precedence: .logicalDisjunction, associativity: .left, isCommutative: true) }
}
