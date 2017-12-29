//
//  NumericUnaryOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/28/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A unary operator for performing arithmetic on numeric types.
public protocol NumericUnaryOperatorProtocol: UnaryOperatorProtocol where Operand: Numeric, Result == Operand {
    /// The unary plus operator (+).
    static var unaryPlus: Self { get }
}

// MARK: Default implementations

extension NumericUnaryOperatorProtocol {
    public static var unaryPlus: Self { return .init(identifier: "+", apply: +) }
}

extension NumericUnaryOperatorProtocol where Operand: SignedNumeric {
    /// The unary minus operator (-).
    public static var unaryMinus: Self { return .init(identifier: "-", apply: -) }
}
