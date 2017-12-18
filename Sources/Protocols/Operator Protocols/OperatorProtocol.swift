//
//  OperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public protocol OperatorProtocol: Equatable, CustomStringConvertible {
    associatedtype Operand
    associatedtype Result
    var identifier: String { get }
}

extension OperatorProtocol {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

extension OperatorProtocol {
    public var description: String {
        return identifier
    }
}
