//
//  ObjectReferenceBinaryOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/18/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A binary operator that operates on reference equatable types.
public protocol ReferenceEquatableOperatorProtocol: BinaryOperatorProtocol where Operand: AnyObject, Result == Bool {
    /// The identity-testing equality operator (===).
    static var identical: Self { get }

    /// The identity-testing inequality operator (!==).
    static var notIdentical: Self { get }
}

// MARK: - Default implementations

extension ReferenceEquatableOperatorProtocol {
    public static var identical: Self { return .init(identifier: "===", apply: ===, precedence: .comparison, associativity: .none, isCommutative: true) }
    public static var notIdentical: Self { return .init(identifier: "!==", apply: !==, precedence: .comparison, associativity: .none, isCommutative: true) }
}
