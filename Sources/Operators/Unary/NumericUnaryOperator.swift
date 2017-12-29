//
//  NumericUnaryOperator.swift
//  Expression
//
//  Created by Michael Pangburn on 12/28/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A unary operator for performing arithmetic on numeric types.
public struct NumericUnaryOperator<T: Numeric>: NumericUnaryOperatorProtocol {
    public typealias Operand = T
    public typealias Result = T

    public let identifier: String
    public let apply: (Operand) -> Result

    public init(identifier: String, apply: @escaping (Operand) -> Result) {
        self.identifier = identifier
        self.apply = apply
    }
}
