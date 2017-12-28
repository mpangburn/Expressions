//
//  LogicalUnaryOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/26/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public protocol LogicalUnaryOperatorProtocol: UnaryOperatorProtocol where Operand == Bool, Result == Bool {
    static var logicalNOT: Self { get }
}

// MARK: - Default implementations

extension LogicalUnaryOperatorProtocol {
    public static var logicalNOT: Self { return .init(identifier: "!", apply: !) }
}
