//
//  ComparativeOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/18/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A binary operator that operates on comparable types.
public protocol ComparativeOperatorProtocol: EquatableOperatorProtocol where Operand: Comparable { }

// MARK: - Operators

extension ComparativeOperatorProtocol {
    public static var lessThan: Self { return .init(identifier: "<", apply: <, precedence: .comparison, associativity: .none, isCommutative: false) }
    public static var lessThanOrEqual: Self { return .init(identifier: "<=", apply: <=, precedence: .comparison, associativity: .none, isCommutative: false) }
    public static var greaterThan: Self { return .init(identifier: ">", apply: >, precedence: .comparison, associativity: .none, isCommutative: false) }
    public static var greaterThanOrEqual: Self { return .init(identifier: ">=", apply: >=, precedence: .comparison, associativity: .none, isCommutative: false) }
}
