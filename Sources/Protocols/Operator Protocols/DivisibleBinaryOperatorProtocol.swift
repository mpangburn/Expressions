//
//  DivisibleBinaryOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A binary operator that operates on divisible types.
public protocol DivisibleBinaryOperatorProtocol: NumericBinaryOperatorProtocol where Operand: Divisible {
    init(identifier: String, apply: @escaping (Operand, Operand) -> Operand, precedence: BinaryOperatorPrecedence,
         associativity: BinaryOperatorAssociativity, isCommutative: Bool)

    /// The division operator (/).
    static var divide: Self { get }
}

// MARK: - Default implementations

extension DivisibleBinaryOperatorProtocol {
    public static var divide: Self { return Self.init(identifier: "/", apply: /, precedence: .multiplication, associativity: .left, isCommutative: false) }
}
