//
//  EquatableOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/18/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A binary operator that operates on equatable types.
protocol EquatableOperatorProtocol: BinaryOperatorProtocol where Operand: Equatable, Result == Bool {
    init(identifier: String, apply: @escaping (Operand, Operand) -> Bool, precedence: BinaryOperatorPrecedence,
    associativity: BinaryOperatorAssociativity, isCommutative: Bool)

    /// The equality-testing operator (==).
    static var equal: Self { get }

    /// The inequality-testing operator (!==).
    static var notEqual: Self { get }

    /// The value equality-testing operator (~=).
    static var valueEquals: Self { get }
}

// MARK: - Default implementations

extension EquatableOperatorProtocol {
    static var equal: Self { return Self.init(identifier: "==", apply: ==, precedence: .comparison, associativity: .none, isCommutative: true) }
    static var notEqual: Self { return Self.init(identifier: "!=", apply: !=, precedence: .comparison, associativity: .none, isCommutative: true) }
    static var valueEquals: Self { return Self.init(identifier: "~=", apply: ~=, precedence: .comparison, associativity: .none, isCommutative: true) }
}
