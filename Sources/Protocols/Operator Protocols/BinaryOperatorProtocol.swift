//
//  BinaryOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/16/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public protocol BinaryOperatorProtocol: OperatorProtocol {
    associatedtype Precedence: BinaryOperatorPrecedenceProtocol
    var precedence: Precedence { get }
    var associativity: BinaryOperatorAssociativity { get }
    var apply: (Operand, Operand) -> Result { get }
    var isCommutative: Bool { get }
}
