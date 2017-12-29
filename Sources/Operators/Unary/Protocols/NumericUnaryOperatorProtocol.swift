//
//  NumericUnaryOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/28/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/// A unary operator for performing arithmetic on numeric types.
public protocol NumericUnaryOperatorProtocol: UnaryOperatorProtocol where Operand: Numeric, Result == Operand { }
