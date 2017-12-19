//
//  ObjectReferenceBinaryOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/18/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A binary operator that operates on reference equatable types.
protocol ReferenceEquatableOperatorProtocol: BinaryOperatorProtocol where Operand: AnyObject, Result == Bool {
    init(identifier: String, apply: @escaping (Operand, Operand) -> Bool, precedence: BinaryOperatorPrecedence,
         associativity: BinaryOperatorAssociativity, isCommutative: Bool)

    /// The identity-testing equality operator (===).
    static var identical: Self { get }

    /// The identity-testing inequality operator (!==).
    static var notIdentical: Self { get }
}

// MARK: - Default implementations

extension ReferenceEquatableOperatorProtocol {
    static var identical: Self { return Self.init(identifier: "===", apply: ===, precedence: .comparison, associativity: .none, isCommutative: true) }
    static var notIdentical: Self { return Self.init(identifier: "!==", apply: !==, precedence: .comparison, associativity: .none, isCommutative: true) }
}
