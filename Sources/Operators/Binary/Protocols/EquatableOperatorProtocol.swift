//
//  EquatableOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/18/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A binary operator that operates on equatable types.
public protocol EquatableOperatorProtocol: BinaryOperatorProtocol where Operand: Equatable, Result == Bool {
    /// The equality testing operator (==).
    static var equal: Self { get }

    /// The inequality testing operator (!==).
    static var notEqual: Self { get }

    /// The value equality testing operator (~=).
    static var valueEqual: Self { get }
}

// MARK: - Default implementations

extension EquatableOperatorProtocol {
    public static var equal: Self { return .init(identifier: "==", apply: ==, precedence: .comparison, associativity: .none, isCommutative: true) }
    public static var notEqual: Self { return .init(identifier: "!=", apply: !=, precedence: .comparison, associativity: .none, isCommutative: true) }
    public static var valueEqual: Self { return .init(identifier: "~=", apply: ~=, precedence: .comparison, associativity: .none, isCommutative: true) }
}
