//
//  LogicalBinaryOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/18/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A binary operator that applies boolean logic.
protocol LogicalBinaryOperatorProtocol: BinaryOperatorProtocol where Operand == Bool, Result == Bool {
    /// The logical AND operator (&&).
    static var logicalAND: Self { get }

    /// The logical OR operator (||).
    static var logicalOR: Self { get }
}

// MARK: - Default implementations

extension LogicalBinaryOperatorProtocol {
    // Since the type of && and || as operators in Swift is actually `(Bool, @autoclosure () throws -> Bool) throws -> Bool`
    // (presumably for short-circuiting purposes), we must wrap these operators in closures.
    static var logicalAND: Self { return Self(identifier: "&&", apply: { $0 && $1 }, precedence: .logicalConjunction, associativity: .left, isCommutative: true) }
    static var logicalOR: Self { return Self(identifier: "||", apply: { $0 || $1 }, precedence: .logicalDisjunction, associativity: .left, isCommutative: true) }
}
