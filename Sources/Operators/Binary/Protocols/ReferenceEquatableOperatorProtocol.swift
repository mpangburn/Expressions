//
//  ObjectReferenceBinaryOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/18/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

/// A binary operator that operates on reference equatable types.
public protocol ReferenceEquatableOperatorProtocol: BinaryOperatorProtocol where Operand: AnyObject, Result == Bool { }

// MARK: - Operators

extension ReferenceEquatableOperatorProtocol {
    public static var identical: Self { return .init(identifier: "===", apply: ===, precedence: .comparison, associativity: .none, isCommutative: true) }
    public static var notIdentical: Self { return .init(identifier: "!==", apply: !==, precedence: .comparison, associativity: .none, isCommutative: true) }
}
