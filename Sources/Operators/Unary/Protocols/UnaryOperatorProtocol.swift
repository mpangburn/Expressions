//
//  UnaryOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/26/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

/// An operator that performs an operation on a single operand.
public protocol UnaryOperatorProtocol: OperatorProtocol {
    init(identifier: String, apply: @escaping (Operand) -> Result)

    /// The function to apply to a single operand to produce the result.
    var apply: (Operand) -> Result { get }
}
