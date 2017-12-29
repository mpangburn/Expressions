//
//  LogicalUnaryOperator.swift
//  Expression
//
//  Created by Michael Pangburn on 12/27/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public struct LogicalUnaryOperator: LogicalUnaryOperatorProtocol {
    public typealias Operand = Bool
    public typealias Result = Bool

    public let identifier: String
    public let apply: (Operand) -> Result

    public init(identifier: String, apply: @escaping (Operand) -> Result) {
        self.identifier = identifier
        self.apply = apply
    }
}
