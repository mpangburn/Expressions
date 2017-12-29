//
//  NumericUnaryOperatorProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/28/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public protocol NumericUnaryOperatorProtocol: UnaryOperatorProtocol where Operand: Numeric, Result == Operand { }
