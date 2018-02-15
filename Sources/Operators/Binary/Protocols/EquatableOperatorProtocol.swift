//
//  EquatableOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/18/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

/// A binary operator that operates on equatable types.
public protocol EquatableOperatorProtocol: BinaryOperatorProtocol where Operand: Equatable, Result == Bool { }

// MARK: - Operators

extension EquatableOperatorProtocol {
    public static var equal: Self { return .init(identifier: "==", apply: ==, precedence: .comparison, associativity: .none, isCommutative: true) }
    public static var notEqual: Self { return .init(identifier: "!=", apply: !=, precedence: .comparison, associativity: .none, isCommutative: true) }
    public static var valueEqual: Self { return .init(identifier: "~=", apply: ~=, precedence: .comparison, associativity: .none, isCommutative: true) }
}
