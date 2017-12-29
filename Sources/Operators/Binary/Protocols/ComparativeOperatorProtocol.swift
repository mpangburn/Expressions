//
//  ComparativeOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/18/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A binary operator that operates on comparable types.
public protocol ComparativeOperatorProtocol: EquatableOperatorProtocol where Operand: Comparable {
    /// The 'less than' testing operator (<).
    static var lessThan: Self { get }

    /// The 'less than or equal' testing operator (<=).
    static var lessThanOrEqual: Self { get }

    /// The 'greater than' testing operator (>).
    static var greaterThan: Self { get }

    /// The 'greater than or equal' testing operator (>=).
    static var greaterThanOrEqual: Self { get }
}

// MARK: - Default implementations

extension ComparativeOperatorProtocol {
    public static var lessThan: Self { return .init(identifier: "<", apply: <, precedence: .comparison, associativity: .none, isCommutative: false) }
    public static var lessThanOrEqual: Self { return .init(identifier: "<=", apply: <=, precedence: .comparison, associativity: .none, isCommutative: false) }
    public static var greaterThan: Self { return .init(identifier: ">", apply: >, precedence: .comparison, associativity: .none, isCommutative: false) }
    public static var greaterThanOrEqual: Self { return .init(identifier: ">=", apply: >=, precedence: .comparison, associativity: .none, isCommutative: false) }
}
